Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IJO5rT022596
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 15:24:06 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IJNNho011902
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 19:23:23 GMT
Date: Wed, 18 Aug 2004 16:37:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy for k3b (and cdrecord)
Message-ID: <20040818153731.GF19646@lkcl.net>
References: <20040817183311.GR18321@lkcl.net> <200408182054.46451.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408182054.46451.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 18, 2004 at 08:54:46PM +1000, Russell Coker wrote:
> On Wed, 18 Aug 2004 04:33, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i'm writing a policy for k3b (kde cd burner) and cdrecord because
> > write access by users to /dev/hdc is banned (policy violation) and
> > because, well, because.
> 
> Why not change the type of /dev/hdc to removable_device_t and define 
> user_rw_noexattrfile when compiling the policy?  That should be all that the 
> CD burner needs.

 drat.  thank you.

 now why didn't i think of changing the type of /dev/hdc?

 hey, well, i've done the policy now, i might as well use it.

 unless.... of course... DVD and CD _reading_ *sigh*.

 that's up the creek, too.

 which your suggestion would fix as well.

 thank you russell: advice really appreciated, you saved me a lot of
 time and hassle.



> If you have a special policy for burning CDs then that policy needs to be 
> limited to only files that the user can access.
> 
> > - for more generic use, obviously k3b must be allowed to access pretty
> >   much anything on / so what should i put in place of all the
> >   dontaudits and allow k3b_t user_home_t etc. stuff?
> 
> If you have a domain k3b_t which is entered from any user domain then user_t 
> can use it to write files from a staff_r home directory to a CD...
 
 i allowed a lot of getattrs for directory access (and then removed
 them / turned them into dontaudits) before i realised of course that
 k3b was directory-scanning with find.

 once i realised that, i began to be more selective: i don't believe i
 added permission to read or scan the contents of /root for example.

 so really i should do something similar to the mozilla thing, then.

 namely, macro-ise it, use x_client_domain, that sort of thing.

 
 [btw it turns out that k3b doesn't actually do any cd-burning itself:
  it's just a front-end to running cdrecord, cdrdao and dvd+rw-format.]

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
