Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t61GTF6a023935
 for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2015 12:29:15 -0400
Date: Wed, 1 Jul 2015 16:26:17 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: Jeff Vander Stoep <jeffv@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <1927858263.794069.1435767977962.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <1435764673-33925-1-git-send-email-jeffv@google.com>
References: <1435764673-33925-1-git-send-email-jeffv@google.com>
Subject: Re: [PATCH] libselinux: Fix file labels for regexes with metachars
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> On Wednesday, 1 July 2015, 16:35, Jeff Vander Stoep <jeffv@google.com> wrote:
> > File labels assigned using the lookup_best_match() function do not
> assign the best match if its regex contains metacharacters.
> 
> For non-exact regex matches, lookup_best_match() finds the closest match
> by tracking the length of the matching prefix. Prefix match is tracked via
> the prefix_len variable. This was previously calculated and set in
> the spec_hasMetaChars() function. Commit 3cb6078 removed the
> prefix_len calculation, this commit restores it.
> 

> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Ack - Thanks fixes the problem


> ---
> libselinux/src/label_file.h | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 73bcbba..30bc911 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -148,6 +148,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
>     end = c + len;
> 
>     spec->hasMetaChars = 0;
> +    spec->prefix_len = len;
> 
>     /* Look at each character in the RE specification string for a
>      * meta character. Return when any meta character reached. */
> @@ -164,6 +165,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
>         case '(':
>         case '{':
>             spec->hasMetaChars = 1;
> +            spec->prefix_len = c - spec->regex_str;
>             return;
>         case '\\':    /* skip the next character */
>             c++;
> -- 
> 2.4.3.573.g4eafbef
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
> 
