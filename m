Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A47@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "'Tom'" <tom@lemuria.org>
Cc: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: RE: login messages
Date: Mon, 6 Oct 2003 15:17:42 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, I have performed a "make load" from the policy direcotry to rebuild
and load the policy.  I have also rebuilt the initrd file using mkinitrd.  I
still cannot switch roles.  What else can I look at?

-----Original Message-----
From: Tom [mailto:tom@lemuria.org]
Sent: Monday, October 06, 2003 1:56 PM
To: Kratzer, James R.
Cc: SELinux (E-mail)
Subject: Re: login messages


On Mon, Oct 06, 2003 at 10:35:39AM -0400, Kratzer, James R. wrote:
> When I then try to switch to the sysadm role from the user role, I get the
> following message.  In my policy "user" file, I have jamesk set for {
> staff_r sysadm_r } roles.  Why can't I switch?
> 
> # newrole -r sysadm_r
> jamesk:sysadm_r:sysadm_t is not a valid context

Have you rebuild and reloaded the policy after you made this change?
Any changes you make to SELinux policy will not take effect until that
policy is compiled and loaded into the kernel.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
