Subject: Re: [patch] Bug in restorecon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070604031847.0ec6c158.ynakam@hitachisoft.jp>
References: <20070604031847.0ec6c158.ynakam@hitachisoft.jp>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 09:28:44 -0400
Message-Id: <1180963724.14220.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-04 at 03:18 +0900, Yuichi Nakamura wrote:
> Hi.
> 
> I found a bug in restorecon in trunk.
> restorecon to relative path does not work.
> (such as restorecon -R .).
> Path is expanded by realpath in restorecon, isn't it ?
> 
> Following is a fix.
> 
> Index: policycoreutils/setfiles/setfiles.c
> ===================================================================
> --- policycoreutils/setfiles/setfiles.c (revision 2457)
> +++ policycoreutils/setfiles/setfiles.c (working copy)
> @@ -223,19 +223,19 @@
>         /* fullname will be the real file that gets labeled
>          * name will be what is matched in the policy */
>         if (NULL != rootpath) {
> -               if (0 != strncmp(rootpath, name, rootpathlen)) {
> +               if (0 != strncmp(rootpath, fullname, rootpathlen)) {
>                         fprintf(stderr, "%s:  %s is not located in %s\n",
> -                               progname, name, rootpath);
> +                               progname, fullname, rootpath);
>                         return -1;
>                 }
> -               name += rootpathlen;
> +               fullname += rootpathlen;
>         }
>  
> -       if (rootpath != NULL && name[0] == '\0')
> +       if (rootpath != NULL && fullname[0] == '\0')
>                 /* this is actually the root dir of the alt root */
>                 return matchpathcon_index("/", sb->st_mode, con);
>         else
> -               return matchpathcon_index(name, sb->st_mode, con);
> +               return matchpathcon_index(fullname, sb->st_mode, con);
>  }
>  
>  void usage(const char *const name)

In that case, why have 'fullname' vs. 'name' at all?  Just directly
manipulate name and use it throughout.

Make sure that setfiles -r /path/to/altroot
file_contexts /path/to/altroot still works as expected, e.g.
labels /path/to/altroot/etc/shadow with the label of /etc/shadow in
policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
