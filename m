Subject: Re: X policy classes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Eamon Walsh <ewalsh@epoch.ncsc.mil>
In-Reply-To: <40A5014A.9060400@snu.edu>
References: <40A464EB.5030008@snu.edu>
	 <1084536340.17741.15.camel@moss-spartans.epoch.ncsc.mil>
	 <40A5014A.9060400@snu.edu>
Content-Type: text/plain
Message-Id: <1084556829.18592.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 May 2004 13:47:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-05-14 at 13:26, Joshua Brindle wrote:
> --- security_classes.orig       2004-05-13 20:15:19.898433608 -0500
> +++ security_classes    2004-05-13 12:37:47.489834072 -0500
> @@ -47,6 +47,9 @@
>  # passwd/chfn/chsh
>  class passwd
>  
> +# pax flags
> +class pax
> +
>  # SE-X Windows stuff
>  class drawable
>  class window
> 

Hmmm...applying that diff now will perturb the values of the X window
classes, requiring regeneration of the libselinux headers that went out
in the release we just made and requiring a rebuild of any modified X
servers upon a migration from libselinux-1.12 to any newer version.  How
much trouble is it for you to relocate the pax definition after the X
classes and migrate your users?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
