Date: Fri, 3 Oct 2003 16:53:55 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: "Fleischman, Eric" <eric.w.fleischman@boeing.com>, SELinux@tycho.nsa.gov
Subject: Re: Security Officer and System Administrator Separation of Duties
Message-ID: <20031003165350.C30369@lemuria.org>
References: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com> <200310031655.06049.russell@coker.com.au> <20031003121858.H28703@lemuria.org> <200310032132.33691.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310032132.33691.russell@coker.com.au>; from russell@coker.com.au on Fri, Oct 03, 2003 at 09:32:33PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 03, 2003 at 09:32:33PM +1000, Russell Coker wrote:
> I think that perhaps you misunderstood my message.  My point is that anyone 
> who can write to programs such as fsck and run them in their usual context 
> can trivially bypass any other security restrictions.

I get you.

Yes, it appears that a good configuration will need a third role for
software updates and machine-level configurations.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
