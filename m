Date: Mon, 6 Oct 2003 19:56:29 +0200
From: Tom <tom@lemuria.org>
To: "Kratzer, James R." <JamesK@xetron.com>
Cc: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: login messages
Message-ID: <20031006195625.F9448@lemuria.org>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin>; from JamesK@xetron.com on Mon, Oct 06, 2003 at 10:35:39AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
