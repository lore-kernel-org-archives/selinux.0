Subject: Re: segfault in semodule
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@redhat.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <47BEFE89.4080201@manicmethod.com>
References: <1203696668.2914.25.camel@localhost.localdomain>
	 <47BEFE89.4080201@manicmethod.com>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 12:41:53 -0500
Message-Id: <1203702113.2804.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-22 at 11:55 -0500, Joshua Brindle wrote:
> Eric Paris wrote:
> > I added "allow-unknown = deny" in semanage.conf and ran semodule -R
> >
> > [root@dhcp231-146 ~]# semodule -R
> > error parsing semanage configuration file: syntax error
> > semodule:  Could not create semanage handle
> > semodule: handle.c:123: semanage_is_connected: Assertion `sh != ((void *)0)' failed.
> > Segmentation fault
> >
> > It was supposed to bail (allow-unknown is not a valid entry, it should
> > be handle-unknown) but it wasn't supposed to segfault.  Maybe someone
> > who knows this code can find/fix it really quickly, if not I'm sure I'll
> > get to look at it when it gets to the top of my list in 10 or 12
> > months  :)
> >
> > policycoreutils-2.0.43-2.fc9.x86_64
> >   
> 
> This is totally untested but should fix it:

I suppose the other option would be to make semanage_is_connected()
return 0 if sh == NULL rather than assert'ing that sh is non-NULL.
Then the same error path could be used.  

> 
> Index: trunk/policycoreutils/semodule/semodule.c
> ===================================================================
> --- trunk/policycoreutils/semodule/semodule.c   (revision 2808)
> +++ trunk/policycoreutils/semodule/semodule.c   (working copy)
> @@ -285,7 +285,7 @@
>         if (!sh) {
>                 fprintf(stderr, "%s:  Could not create semanage handle\n",
>                         argv[0]);
> -               goto cleanup;
> +               goto cleanup_nohandle;
>         }
>  
>         if (store) {
> @@ -473,6 +473,8 @@
>                 }
>         }
>         semanage_handle_destroy(sh);
> +
> +      cleanup_nohandle:
>         cleanup();
>         exit(status);
>  }
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
