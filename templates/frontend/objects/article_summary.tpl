{**
 * templates/frontend/objects/article_summary.tpl
 *}
{assign var=articlePath value=$article->getBestId()}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}

{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

{assign var=publication value=$article->getCurrentPublication()}
<div class="obj_article_summary">
	{if $publication->getLocalizedData('coverImage')}
		<div class="cover">
			<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if} class="file">
				{assign var="coverImage" value=$article->getCurrentPublication()->getLocalizedData('coverImage')}
				<img
					src="{$article->getCurrentPublication()->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
					alt="{$coverImage.altText|escape|default:''}"
				>
			</a>
		</div>
	{/if}

	<{$heading} class="title">
		<a id="article-{$article->getId()}" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
			{$article->getLocalizedTitle()|strip_unsafe_html}
			{if $article->getLocalizedSubtitle()}
				<span class="subtitle">
					{$article->getLocalizedSubtitle()|escape}
				</span>
			{/if}
		</a>
	</{$heading}>

	{if $showAuthor || $article->getPages() || ($article->getDatePublished() && $showDatePublished)}
	<div class="meta">
		{if $showAuthor}
		<div class="authors">
			{$article->getAuthorString()|escape}
		</div>
		{/if}

		{* Page numbers for this article *}
		{if $article->getPages()}
			<div class="pages">
				{$article->getPages()|escape}
			</div>
		{/if}

		{if $showDatePublished && $article->getDatePublished()}
			<div class="published">
				{$article->getDatePublished()|date_format:$dateFormatShort}
			</div>
		{/if}

	</div>
	{/if}
	<br>{assign var=galleys value=$article->getGalleys()}
	<i class='fa fa-bar-chart' style='color: red'></i> </span> <b>Visualizações: {$article->getViews()}</b><br>
	{if !$hideGalleys}
		<ul class="galleys_links">
			{foreach from=$article->getGalleys() item=galley}
				</li><i class='fa fa-download' style='color: red'></i> {$galley->getViews()}{if $primaryGenreIds}
					{assign var="file" value=$galley->getFile()}
					{if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
						{continue}
					{/if}
				{/if}
				<li>
					{assign var="hasArticleAccess" value=$hasAccess}
					{if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN}
						{assign var="hasArticleAccess" value=1}
					{/if}
					{include file="frontend/objects/galley_link.tpl" parent=$article labelledBy="article-{$article->getId()}" hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
				</li>
			{/foreach}
		</ul>
	{/if}

	{call_hook name="Templates::Issue::Issue::Article"}
	
	
	
	
</div>
