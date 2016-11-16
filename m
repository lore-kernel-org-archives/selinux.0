Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAGGfsaO029135
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 11:41:54 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so15114261pgd.0
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 08:41:52 -0800 (PST)
Date: Thu, 17 Nov 2016 00:41:49 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/5] mcstrans: Fix Werror=shadow errors
Message-ID: <20161116164149.GA27247@meriadoc.perfinion.com>
References: <1479305122-2419-1-git-send-email-jason@perfinion.com>
 <20161116155714.GA6564@meriadoc.perfinion.com>
 <ce497b56-c79d-bbbf-36df-a80a01599d6c@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ce497b56-c79d-bbbf-36df-a80a01599d6c@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 16, 2016 at 11:29:58AM -0500, Stephen Smalley wrote:
> On 11/16/2016 10:57 AM, Jason Zaman wrote:
> > This whole series applies on top of the splitpolicycoreutils branch.
> 
> Thanks, applied on that branch (+ re-based again).
> This reminds me that I need to figure out what to do about ChangeLogs
> for the new subdirs split from policycoreutils.  mcstrans has an old one
> from when it was originally a separate, external project, that is
> obviously out of date and stale.  The others don't have one at all.
> Options:
> 1) Update the mcstrans ChangeLog with any mcstrans changes since it was
> merged to policycoreutils and then keep on updating it.  Create new
> ChangeLogs for the new subdirs and initially populate them from the
> relevant entries from the policycoreutils ChangeLog, at least for
> changes since 2.6.
> or
> 2) Drop the ChangeLogs altogether and just let people use git to
> generate changelogs between releases.

The new subdirs can just start from scratch with a note to refer to
policycoreutils for earlier stuff. mcstrans could just have a note
about the missing gap.

I'm in favour of dropping them completely tho. Or if you really want them,
only update the changelogs from git only right before releases. Having a
second commit after every other one repeating the same commit msg seems
wasteful.

Something like: git log --pretty=format:'%s <%an>' > ChangeLog

-- Jason

> > 
> > On Wed, Nov 16, 2016 at 10:05:18PM +0800, Jason Zaman wrote:
> >> gcc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -fPIE -c -o mcstrans.o mcstrans.c
> >> mcstrans.c: In function ‘violates_constraints’:
> >> mcstrans.c:551:14: error: declaration of ‘common’ shadows a previous local [-Werror=shadow]
> >>     ebitmap_t common;
> >>               ^
> >> mcstrans.c:545:13: error: shadowed declaration is here [-Werror=shadow]
> >>    ebitmap_t common;
> >>              ^
> >> mcstrans.c: In function ‘build_regexps’:
> >> mcstrans.c:1048:7: error: declaration of ‘i’ shadows a previous local [-Werror=shadow]
> >>    int i=0;
> >>        ^
> >> mcstrans.c:993:15: error: shadowed declaration is here [-Werror=shadow]
> >>   size_t n_el, i;
> >>                ^
> >> mcstrans.c: In function ‘compute_raw_from_trans’:
> >> mcstrans.c:1166:9: error: declaration of ‘rc’ shadows a previous local [-Werror=shadow]
> >>      int rc = pcre_exec(g->prefix_regexp, 0, work, work_len, 0, 0, ovector, OVECCOUNT);
> >>          ^
> >> mcstrans.c:1123:6: error: shadowed declaration is here [-Werror=shadow]
> >>   int rc = pcre_exec(domain->base_classification_regexp, 0, work, work_len, 0, PCRE_ANCHORED, ovector, OVECCOUNT);
> >>       ^
> >> mcstrans.c:1174:9: error: declaration of ‘rc’ shadows a previous local [-Werror=shadow]
> >>      int rc = pcre_exec(g->suffix_regexp, 0, work, work_len, 0, 0, ovector, OVECCOUNT);
> >>          ^
> >> mcstrans.c:1123:6: error: shadowed declaration is here [-Werror=shadow]
> >>   int rc = pcre_exec(domain->base_classification_regexp, 0, work, work_len, 0, PCRE_ANCHORED, ovector, OVECCOUNT);
> >>       ^
> >> mcstrans.c:1189:9: error: declaration of ‘rc’ shadows a previous local [-Werror=shadow]
> >>      int rc = pcre_exec(g->word_regexp, 0, s, l, 0, 0, ovector, OVECCOUNT);
> >>          ^
> >> mcstrans.c:1123:6: error: shadowed declaration is here [-Werror=shadow]
> >>   int rc = pcre_exec(domain->base_classification_regexp, 0, work, work_len, 0, PCRE_ANCHORED, ovector, OVECCOUNT);
> >>       ^
> >> mcstrans.c: In function ‘compute_trans_from_raw’:
> >> mcstrans.c:1328:14: error: declaration of ‘unhandled’ shadows a previous local [-Werror=shadow]
> >>     ebitmap_t unhandled, orig_unhandled;
> >>               ^
> >> mcstrans.c:1291:49: error: shadowed declaration is here [-Werror=shadow]
> >>   ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
> >>                                                  ^
> >> mcstrans.c:1328:25: error: declaration of ‘orig_unhandled’ shadows a previous local [-Werror=shadow]
> >>     ebitmap_t unhandled, orig_unhandled;
> >>                          ^
> >> mcstrans.c:1291:60: error: shadowed declaration is here [-Werror=shadow]
> >>   ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
> >>                                                             ^
> >> mcstrans.c:1360:15: error: declaration of ‘handled’ shadows a previous local [-Werror=shadow]
> >>      ebitmap_t handled, nothandled;
> >>                ^
> >> mcstrans.c:1291:28: error: shadowed declaration is here [-Werror=shadow]
> >>   ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
> >>                             ^
> >> mcstrans.c:1360:24: error: declaration of ‘nothandled’ shadows a previous local [-Werror=shadow]
> >>      ebitmap_t handled, nothandled;
> >>                         ^
> >> mcstrans.c:1291:37: error: shadowed declaration is here [-Werror=shadow]
> >>   ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
> >>                                      ^
> >> mcstrans.c:1377:17: error: declaration of ‘temp’ shadows a previous local [-Werror=shadow]
> >>        ebitmap_t temp;
> >>                  ^
> >> mcstrans.c:1291:22: error: shadowed declaration is here [-Werror=shadow]
> >>   ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
> >>                       ^
> >> mcstrans.c:1378:17: error: declaration of ‘bit_diff’ shadows a previous local [-Werror=shadow]
> >>        ebitmap_t bit_diff;
> >>                  ^
> >> mcstrans.c:1291:12: error: shadowed declaration is here [-Werror=shadow]
> >>   ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
> >>             ^
> >> mcstrans.c:1403:16: error: declaration of ‘bit_diff’ shadows a previous local [-Werror=shadow]
> >>       ebitmap_t bit_diff;
> >>                 ^
> >> mcstrans.c:1291:12: error: shadowed declaration is here [-Werror=shadow]
> >>   ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
> >>             ^
> >> mcstrans.c:1407:16: error: declaration of ‘temp’ shadows a previous local [-Werror=shadow]
> >>       ebitmap_t temp;
> >>                 ^
> >> mcstrans.c:1291:22: error: shadowed declaration is here [-Werror=shadow]
> >>   ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
> >>                       ^
> >> mcstrans.c:1434:19: error: declaration of ‘g’ shadows a previous local [-Werror=shadow]
> >>      word_group_t *g;
> >>                    ^
> >> mcstrans.c:1335:18: error: shadowed declaration is here [-Werror=shadow]
> >>     word_group_t *g;
> >>                   ^
> >> cc1: all warnings being treated as errors
> >> Makefile:35: recipe for target 'mcstrans.o' failed
> >> make[2]: *** [mcstrans.o] Error 1
> >>
> >> Signed-off-by: Jason Zaman <jason@perfinion.com>
> >> ---
> >>  mcstrans/src/mcstrans.c | 24 ++++++++----------------
> >>  1 file changed, 8 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> >> index d7f094a..1b77d16 100644
> >> --- a/mcstrans/src/mcstrans.c
> >> +++ b/mcstrans/src/mcstrans.c
> >> @@ -525,9 +525,9 @@ int
> >>  violates_constraints(mls_level_t *l) {
> >>  	int nbits;
> >>  	sens_constraint_t *s;
> >> +	ebitmap_t common;
> >>  	for (s=sens_constraints; s; s=s->next) {
> >>  		if (s->sens == l->sens) {
> >> -			ebitmap_t common;
> >>  			if (ebitmap_and(&common, &s->cat, &l->cat) < 0)
> >>  				return 1;
> >>  			nbits = ebitmap_cardinality(&common);
> >> @@ -542,13 +542,11 @@ violates_constraints(mls_level_t *l) {
> >>  	}
> >>  	cat_constraint_t *c;
> >>  	for (c=cat_constraints; c; c=c->next) {
> >> -		ebitmap_t common;
> >>  		if (ebitmap_and(&common, &c->mask, &l->cat) < 0)
> >>  			return 1;
> >>  		nbits = ebitmap_cardinality(&common);
> >>  		ebitmap_destroy(&common);
> >>  		if (nbits > 0) {
> >> -			ebitmap_t common;
> >>  			if (ebitmap_and(&common, &c->cat, &l->cat) < 0)
> >>  				return 1;
> >>  			nbits = ebitmap_cardinality(&common);
> >> @@ -1045,7 +1043,7 @@ build_regexps(domain_t *domain) {
> >>  			return -1;
> >>  		}
> >>  
> >> -		int i=0;
> >> +		i=0;
> >>  		for (w = g->words; w; w = w->next)
> >>  			g->sword[i++]=w;
> >>  
> >> @@ -1094,6 +1092,7 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
> >>  	gettimeofday(&startTime, 0);
> >>  #endif
> >>  
> >> +	int rc = 0;
> >>  	int ovector[OVECCOUNT];
> >>  	word_group_t *g = NULL;
> >>  	char *work = NULL;
> >> @@ -1120,7 +1119,7 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
> >>  	if (!domain->base_classification_regexp)
> >>  		goto err;
> >>  	log_debug(" compute_raw_from_trans work = %s\n", work);
> >> -	int rc = pcre_exec(domain->base_classification_regexp, 0, work, work_len, 0, PCRE_ANCHORED, ovector, OVECCOUNT);
> >> +	rc = pcre_exec(domain->base_classification_regexp, 0, work, work_len, 0, PCRE_ANCHORED, ovector, OVECCOUNT);
> >>  	if (rc > 0) {
> >>  		match = NULL;
> >>  		pcre_get_substring(work, ovector, rc, 0, &match);
> >> @@ -1163,7 +1162,7 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
> >>  			int prefix_offset = 0, prefix_len = 0;
> >>  			int suffix_offset = 0, suffix_len = 0;
> >>  			if (g->prefix_regexp) {
> >> -				int rc = pcre_exec(g->prefix_regexp, 0, work, work_len, 0, 0, ovector, OVECCOUNT);
> >> +				rc = pcre_exec(g->prefix_regexp, 0, work, work_len, 0, 0, ovector, OVECCOUNT);
> >>  				if (rc > 0) {
> >>  					prefix = 1;
> >>  					prefix_offset = ovector[0];
> >> @@ -1171,7 +1170,7 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
> >>  				}
> >>  			}
> >>  			if (g->suffix_regexp) {
> >> -				int rc = pcre_exec(g->suffix_regexp, 0, work, work_len, 0, 0, ovector, OVECCOUNT);
> >> +				rc = pcre_exec(g->suffix_regexp, 0, work, work_len, 0, 0, ovector, OVECCOUNT);
> >>  				if (rc > 0) {
> >>  					suffix = 1;
> >>  					suffix_offset = ovector[0];
> >> @@ -1186,7 +1185,7 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
> >>  			     g->word_regexp) {
> >>  				char *s = work + prefix_offset + prefix_len;
> >>  				int l = (suffix_len ? suffix_offset : work_len) - prefix_len - prefix_offset;
> >> -				int rc = pcre_exec(g->word_regexp, 0, s, l, 0, 0, ovector, OVECCOUNT);
> >> +				rc = pcre_exec(g->word_regexp, 0, s, l, 0, 0, ovector, OVECCOUNT);
> >>  				if (rc > 0) {
> >>  					match = NULL;
> >>  					pcre_get_substring(s, ovector, rc, 0, &match);
> >> @@ -1285,6 +1284,7 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
> >>  	gettimeofday(&startTime, 0);
> >>  #endif
> >>  
> >> +	word_group_t *g;
> >>  	mls_level_t *l = NULL;
> >>  	char *rval = NULL;
> >>  	word_group_t *groups = NULL;
> >> @@ -1325,14 +1325,12 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
> >>  				continue;
> >>  
> >>  			/* compute bits not consumed by base classification */
> >> -			ebitmap_t unhandled, orig_unhandled;
> >>  			if (ebitmap_xor(&unhandled, &l->cat, &bc->level->cat) < 0)
> >>  				goto err;
> >>  			if (ebitmap_cpy(&orig_unhandled, &unhandled) < 0)
> >>  				goto err;
> >>  
> >>  			/* prebuild groups */
> >> -			word_group_t *g;
> >>  			for (g = domain->groups; g; g = g->next) {
> >>  				word_group_t **t;
> >>  				for (t = &groups; *t; t = &(*t)->next)
> >> @@ -1357,7 +1355,6 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
> >>  			for (loops = 50; ebitmap_cardinality(&unhandled) && loops > 0 && change; loops--) {
> >>  				change = 0;
> >>  				hamming = 10000;
> >> -				ebitmap_t handled, nothandled;
> >>  				if (ebitmap_xor(&handled, &unhandled, &orig_unhandled) < 0)
> >>  					goto err;
> >>  				if (ebitmap_not(&nothandled, &handled, maxbit) < 0)
> >> @@ -1374,8 +1371,6 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
> >>  						}
> >>  
> >>  						/* if only unhandled bits are different */
> >> -						ebitmap_t temp;
> >> -						ebitmap_t bit_diff;
> >>  						if (ebitmap_or(&temp, &w->normal, &w->inverse) < 0)
> >>  							goto err;
> >>  						if (ebitmap_and(&bit_diff, &temp, &nothandled) < 0)
> >> @@ -1400,11 +1395,9 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
> >>  				ebitmap_destroy(&nothandled);
> >>  
> >>  				if (currentWord) {
> >> -					ebitmap_t bit_diff;
> >>  					if (ebitmap_xor(&bit_diff, &currentWord->cat, &bc->level->cat) < 0)
> >>  						goto err;
> >>  
> >> -					ebitmap_t temp;
> >>  					if (ebitmap_cpy(&temp, &unhandled) < 0)
> >>  						goto err;
> >>  					ebitmap_destroy(&unhandled);
> >> @@ -1431,7 +1424,6 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
> >>  				buffer[0] = 0;
> >>  				strcat(buffer, bc->trans);
> >>  				strcat(buffer, " ");
> >> -				word_group_t *g;
> >>  				for (g=groups; g; g = g->next) {
> >>  					if (g->words && g->prefixes) {
> >>  						strcat(buffer, g->prefixes->text);
> >> -- 
> >> 2.7.3
> >>
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> > 
> 
