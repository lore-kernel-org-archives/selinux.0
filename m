Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6PGefOb018918
 for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2017 12:40:41 -0400
Message-ID: <1500997019.13149.12.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Date: Tue, 25 Jul 2017 17:36:59 +0200
In-Reply-To: <CAHC9VhTe71CM4i+c86ckbV1GUPdNs1R5sByamZRqLwdYaWcMmw@mail.gmail.com>
References: <CAHC9VhS9QO8jGBodsSeQxxbgoxrmThRgbc3_m17h7gFmfP=GGw@mail.gmail.com>
 <1500899117.2458.2.camel@redhat.com>
 <CAHC9VhRjju-_3V21x+BogdRg-brDho1g_HzW+0CvU0PbhEtQqw@mail.gmail.com>
 <1500912555.2458.12.camel@redhat.com>
 <CAHC9VhSAifQtx3eaQD42XMx8beC08JBGQ9SaKFvkD9qVsT8VCg@mail.gmail.com>
 <CAHC9VhQC1Bpm9VdE2sBC4VLmnzu_B7kLEkgBtnDKvwKf5w1HyA@mail.gmail.com>
 <1500976778.2929.5.camel@redhat.com>
 <CAHC9VhTe71CM4i+c86ckbV1GUPdNs1R5sByamZRqLwdYaWcMmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: SELinux/IP_PASSSEC regression in 4.13-rcX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-07-25 at 10:45 -0400, Paul Moore wrote:
> On Tue, Jul 25, 2017 at 5:59 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> > On Mon, 2017-07-24 at 22:00 -0400, Paul Moore wrote:
> > > > I'm happy to test this, but if you are curious, you can find the
> > > > selinux-testsuite at the link below; the "inet_socket" tests are the
> > > > ones relevant to this problem.
> > > > 
> > > > * https://github.com/SELinuxProject/selinux-testsuite
> > 
> > Thanks, I'll have a look.
> > 
> > > > However, I believe there is a problem with this patch, see below.
> > 
> > [...]
> > 
> > > > > -#if BITS_PER_LONG == 64
> > > > > +#define UDP_SKB_IS_STATELESS 0x80000000
> > > > > +
> > > > >  static void udp_set_dev_scratch(struct sk_buff *skb)
> > > > >  {
> > > > > -       struct udp_dev_scratch *scratch;
> > > > > +       struct udp_dev_scratch *scratch = udp_skb_scratch(skb);
> > > > > 
> > > > >         BUILD_BUG_ON(sizeof(struct udp_dev_scratch) > sizeof(long));
> > > > 
> > > > The BUILD_BUG_ON() assertion no longer appears to be correct with this patch.
> > > 
> > > Nevermind, I just took a closer look at this and realized I made a
> > > mistake when applying your patch (had to apply manually for some
> > > reason).  I'm building a test kernel now.
> > 
> > Yup, I compile-tested the code, plus some basic sanity checks, so the
> > build breakage felt unexpected.
> > 
> > Thanks for testing,
> 
> I just did a quick run through the selinux-testsuite and the
> regression would appear to be fixed, thanks!  I'm guessing you'll send
> this to DaveM so we can get this fixed before v4.13 is released?
> 
> Tested-by: Paul Moore <paul@paul-moore.com>

Sure. I'll submit soon for -net.

Cheers,

Paolo
