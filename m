Date: Tue, 11 Nov 2003 07:34:53 +0100
From: Tom <tom@lemuria.org>
To: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: Patched GDM?
Message-ID: <20031111073452.B2597@lemuria.org>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A5E@s3cin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A5E@s3cin>; from JamesK@xetron.com on Mon, Nov 10, 2003 at 02:36:10PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 10, 2003 at 02:36:10PM -0500, Kratzer, James R. wrote:
> Anyone know where I may find a patched version of GDM which will correctly
> set the context on login?

Write one. :)

As of now, the only graphical login manager I'm aware of with SELinux
support is the one I patched - wdm. You can find it on my website
(http://selinux.lemuria.org) and the patch should soon be included in
the upstream sources.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
