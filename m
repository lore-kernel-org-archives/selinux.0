Subject: Re: Dead links in checkpolicy/checkmodule man pages.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <465C3C94.4020609@redhat.com>
References: <465C3C94.4020609@redhat.com>
Content-Type: text/plain
Date: Thu, 31 May 2007 14:38:30 -0400
Message-Id: <1180636710.3340.337.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-29 at 10:45 -0400, Daniel J Walsh wrote:
> I think we should just move to the toplevel directory
> 
> 
> plain text document attachment (diff)
> --- checkpolicy-2.0.2/checkmodule.8~	2007-04-12 16:03:00.000000000 -0400
> +++ checkpolicy-2.0.2/checkmodule.8	2007-05-29 10:43:29.000000000 -0400
> @@ -47,7 +47,7 @@ $ checkmodule -M -m httpd.te -o httpd.mo
>  
>  .SH "SEE ALSO"
>  .B semodule(8), semodule_package(8)
> -SELinux documentation at http://www.nsa.gov/selinux/docs.html,
> +SELinux documentation at http://www.nsa.gov/selinux,
>  especially "Configuring the SELinux Policy".
>  
> 
> --- checkpolicy-2.0.2/checkpolicy.8~	2007-04-12 16:03:00.000000000 -0400
> +++ checkpolicy-2.0.2/checkpolicy.8	2007-05-29 10:43:21.000000000 -0400
> @@ -34,7 +34,7 @@ Write a binary policy file to the specif
>  Specify the policy version, defaults to the latest.
>  
>  .SH "SEE ALSO"
> -SELinux documentation at http://www.nsa.gov/selinux/docs.html,
> +SELinux documentation at http://www.nsa.gov/selinux,
>  especially "Configuring the SELinux Policy".

Thanks, merged to trunk, stable, and policyrep.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
