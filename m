Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA5MW36f010936
	for <selinux@tycho.nsa.gov>; Sun, 5 Nov 2006 17:32:03 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kA5MUS28017855
	for <selinux@tycho.nsa.gov>; Sun, 5 Nov 2006 22:30:28 GMT
Message-ID: <454E6663.8070609@gentoo.org>
Date: Sun, 05 Nov 2006 17:32:03 -0500
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rpmlint
References: <200611030816.22148.sgrubb@redhat.com>
In-Reply-To: <200611030816.22148.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> Hi,
>
> Below is a patch that I am thinking about submitting to rpmlint. The main idea
> of this patch is to catch places where people might be coding policy knowledge
> into scripts. Chcon would require knowing some types in order to work. If the
> types ever got changed, the script would break. Can anyone think of other
> things we do not want to see in rpm scriplets?
>
> -Steve
>
>   
calling semanage thusly:

semanage fcontext -a [any arguments here] /some/file

actually any semanage command except *possibly* login and user, and I'm 
not sure they should be there either but someone may have an acceptable 
scenerio.
> diff -ur rpmlint-0.78.orig/PostCheck.py rpmlint-0.78/PostCheck.py
> --- rpmlint-0.78.orig/PostCheck.py	2006-11-01 11:13:04.000000000 -0500
> +++ rpmlint-0.78/PostCheck.py	2006-11-01 12:26:49.000000000 -0500
> @@ -38,6 +38,7 @@
>  bracket_regex=re.compile('^[^#]*if.*[^ :\]]\]', re.MULTILINE)
>  home_regex=re.compile('[^a-zA-Z]+~/|\${?HOME(\W|$)', re.MULTILINE)
>  dangerous_command_regex=re.compile("(^|[;\|`]|&&|$\()\s*(?:\S*/s?bin/)?(cp|mv|ln|tar|rpm|chmod|chown|rm|cpio|install|perl|userdel|groupdel)\s", re.MULTILINE)
> +selinux_regex=re.compile("(^|[;\|`]|&&|$\()\s*(?:\S*/s?bin/)?(chcon|runcon)\s", re.MULTILINE)
>  single_command_regex=re.compile("^[ \n]*([^ \n]+)[ \n]*$")
>  update_menu_regex=re.compile('update-menus', re.MULTILINE)
>  tmp_regex=re.compile('\s(/var)?/tmp', re.MULTILINE)
> @@ -139,6 +140,10 @@
>                  res=dangerous_command_regex.search(script)
>                  if res:
>                      printWarning(pkg, 'dangerous-command-in-' + tag[2], res.group(2))
> +                res=selinux_regex.search(script)
> +                if res:
> +                    printError(pkg, 'selinux-forbidden-command-in-' + tag[2], res.group(2))
> +
>                  if update_menu_regex.search(script):
>                      menu_error=1
>                      for f in files:
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
