Subject: Re: How to cross install policy store?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Shaz <shazalive@gmail.com>, TaurusHarry <harrytaurus2002@hotmail.com>,
        dwalsh@redhat.com, selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <4BF3E5C4.4070004@gmail.com>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <4BF28A59.402@redhat.com>
	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
	 <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>
	 <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>
	 <1274210546.8879.139.camel@moss-pluto.epoch.ncsc.mil>
	 <BAY111-W1931F5A339EB7088E04FDFABE20@phx.gbl>
	 <AANLkTilDxLCFs5d0wkzUDHKNpkq7buNKzvFO86qVm9j2@mail.gmail.com>
	 <4BF3E5C4.4070004@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 May 2010 09:34:14 -0400
Message-ID: <1274276054.1143.75.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-05-19 at 06:21 -0700, Justin P. Mattock wrote:
> On 05/19/2010 03:04 AM, Shaz wrote:
> >> It's very true that both SELInux policy and policy store are
> >> arch-independent. It takes about 70 minutes to build the policy store from
> >> scratch on my embedded target, but I could copy and use the host policy
> >> store on the target, only that it will take 20 minutes each time to change
> >> SELinux attribute on the fly by the semanage tool, so I think I'd better
> >> save all the trouble by committing the changes to SELInux source code on the
> >> host instead.
> >
> > Sounds interesting. Let me try it too.
> >
> 
> 
> yep.. I built a policy on x86_64
> then copied it to all my other machines(i586)
> (no problem), but things like libselinux
> will probably be a different story.

Well, yes, because libselinux is executable code.  policy is just data.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
