Subject: Re: determine least upper bound
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: michel m <michel.mcgregor@gmail.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <C1F57EA7-A58C-4270-AC00-D44D199B5FE7@nall.com>
References: <m2zbb74313d1004130956i6ce8e53z6f2ec9bbe385c278@mail.gmail.com>
	 <1271190061.9577.119.camel@moss-pluto.epoch.ncsc.mil>
	 <C1F57EA7-A58C-4270-AC00-D44D199B5FE7@nall.com>
Content-Type: text/plain
Date: Fri, 07 May 2010 09:40:55 -0400
Message-Id: <1273239655.20596.6.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-05-05 at 10:42 -0500, Joe Nall wrote:
> On Apr 13, 2010, at 3:21 PM, Stephen Smalley wrote:
> 
> > On Tue, 2010-04-13 at 21:26 +0430, michel m wrote:
> >> dear all,
> >> is there any way to determine least upper bound among security
> >> contexts? that is,if I got two secuirty contexts, how can I determine
> >> their least upper bound?
> > 
> > I presume you want the least upper bound of two MLS levels?  It doesn't
> > make sense to talk about the least upper bound of two contexts, as the
> > values for the other fields of the context (user, role, type) are
> > unordered.
> > 
> > The first question is why do you need to compute a lub or how do you
> > intend to use the result.
> 
> Sorry for responding so late. We do this to compute a shared level
> to communicate with a community of users.
> 
> We have application level bit twiddling code to do lub computation.
> We then pass the result through mcstrans to see if the resulting
> raw context converts. The code isn't really portable outside our
> code base and assumes all kinds of things about the structure of
> the range portion of the context.

Yes, so we'd prefer to see that implemented as a libsepol function or
selinuxfs interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
