Subject: Re: [PATCH 3/5] libselinux: add string<->value functions that use
	discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1181218773.6578.70.camel@sgc.columbia.tresys.com>
References: <1181157090.6578.38.camel@sgc.columbia.tresys.com>
	 <46674C16.40005@tycho.nsa.gov>
	 <1181218773.6578.70.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 08:20:38 -0400
Message-Id: <1181218838.6578.72.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-07 at 12:19 +0000, Christopher J. PeBenito wrote:
> On Wed, 2007-06-06 at 20:06 -0400, Eamon Walsh wrote:
> > Christopher J. PeBenito wrote:
> > > +	}
> > > +
> > > +	return 0;
> > 
> > Set errno to EINVAL, as mentioned earlier.
> 
> No, you can't do that, the value of EINVAL (22 on my machine) could
> correspond to 3 real permissions.  access_vector_t is unsigned, so it
> can't be negative.  Since access_vector_t is a vector, it makes sense
> for it to be 0.

Never mind, I misread.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
