Subject: Re: kdm patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito"
 <cpebenito@tresys.com>
In-Reply-To: <201102132316.34972.russell@coker.com.au>
References: <201102132316.34972.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Feb 2011 09:45:31 -0500
Message-ID: <1297694731.29692.18.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2011-02-13 at 23:16 +1100, Russell Coker wrote:
> The attached patch makes kdm do all the work of determining the correct SE 
> Linux context.  With this patch there is no need for pam_selinux.so for a kdm 
> login.
> 
> The reason for this is that currently when kdm creates a ~/.xsession-errors 
> file it uses the default level - IE the low level of the kdm process itself.  
> If the user has a low level that's higher than SystemLow then they won't be 
> able to write to the errors file.  My patch makes it call setfscreatecon() 
> before doing that.
> 
> Please tell me what you think, both about the patch itself and the concept.  
> If we go ahead with this then I'll probably have to write similar patches for 
> all the other common xdm programs.

I'd suggest taking the kdm_selinux_* helper functions and turning them
into generic libselinux functions that can be reused by all of the *dm
programs.  That will also allow us to change the internal logic in the
future without having to re-patch the *dm programs.

Have you done a detailed comparison of your logic against the latest
pam_selinux logic?  The pam_selinux logic includes support for user
specification or environmental specification of desired role/level.  If
we are going to directly patch the *dm programs at all, wouldn't it be
better to go ahead and support user selection of role/level as was
supported in some of the early experimental gdm selinux patches?

Also, it will be important to keep in mind that we have wanted to change
the approach to determining user contexts in SELinux for some time (e.g.
eliminate the use of /selinux/user altogether, take more of the logic to
userspace, simplify the logic), so whatever you do here needs to allow
for future replacement without needing to revisit each *dm program.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
