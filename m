Subject: Re: Can we make libsemanage default to expand-check=0
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <489864B4.1090605@redhat.com>
References: <489864B4.1090605@redhat.com>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 10:53:32 -0400
Message-Id: <1217948012.2994.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-08-05 at 10:33 -0400, Daniel J Walsh wrote:
> plain text document attachment (libsemanage-rhat.patch)
> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage.conf libsemanage-2.0.25/src/semanage.conf
> --- nsalibsemanage/src/semanage.conf	2008-06-12 23:25:16.000000000 -0400
> +++ libsemanage-2.0.25/src/semanage.conf	2008-07-17 13:58:44.000000000 -0400
> @@ -35,4 +35,4 @@
>  # given in <sepol/policydb.h>.  Change this setting if a different
>  # version is necessary.
>  #policy-version = 19
> -
> +expand-check=0

I thought we were going to leave this unchanged upstream, and only make
this change in Fedora.

We want the checking to be applied for policy developers.  If you were
to incorporate 'make validate' into the policy spec file, then you would
get it applied when you perform a policy build.  And ideally there would
be similar support in the selinux-policy-devel Makefile for policy
module writers to use.  All it does is run semodule_link followed by
semodule_expand, which applies the checking.

If we were to change the upstream default, we'd likely change it in the
code (semanage_conf_init()) rather than just in the .conf file.  And
then policy developers would need to add expand-check=1 to their .conf
file to set it.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
