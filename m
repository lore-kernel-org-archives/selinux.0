Date: Wed, 9 Jul 2003 10:20:25 +0200
From: Tom <tom@lemuria.org>
To: Bill Laut <wlsel@verizon.net>
Cc: SELinux@tycho.nsa.gov
Subject: Re: SELinux, KDE, and honeypots
Message-ID: <20030709102025.C30693@lemuria.org>
References: <200307082303.22083.wlsel@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200307082303.22083.wlsel@verizon.net>; from wlsel@verizon.net on Tue, Jul 08, 2003 at 11:03:22PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 08, 2003 at 11:03:22PM -0400, Bill Laut wrote:
> (1)  Once I finish cleaning up my gateway/router's policy, I would like to 
> migrate my workstation to SELinux so that I can allow Mozilla to run 
> Javascripting and/or plugins without the fear of my workstation being 
> compromised.  In reading through the archive, it seems the only thing that 
> needs to be modified is kdm.  Is this a correct assumption, or should I 
> expect it to be more involved than that?

Yes, though if I understand correctly, the kdm patch was never actually
tested.

There is a patched wdm available from my website at
http://selinux.lemuria.org

I haven't yet updated it to the most current wdm version, but it works
for me.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
