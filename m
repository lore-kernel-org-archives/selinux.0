Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1IYsXZ028739
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 13:34:54 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1IXWCC023758
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 18:33:33 GMT
Date: Mon, 1 Nov 2004 18:45:38 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   samba-technical@samba.org, tng-technical@lists.samba-tng.org
Subject: Re: dynamic context transitions
Message-ID: <20041101184538.GD9643@lkcl.net>
References: <4182959B.4080503@trustedcs.com> <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net> <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil> <20041101141025.GZ8897@lkcl.net> <418662EE.5090001@trustedcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <418662EE.5090001@trustedcs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 10:23:10AM -0600, Darrel Goeddel wrote:
> James,
>     I am hoping that this response will also address your question of 
> applicability outside of the MLS policy.
> 
> Luke Kenneth Casson Leighton wrote:
> > this proposal is a little bit like seteuid-for-selinux, only not
> > really, because seteuid has the ability to switch to any uid and then
> > to any uid after that, ad infinitum.
> >
> 
> That is correct.  

 great!

> We are looking at a well-defined (via the policy) set of 
> available type transitions.  Note that you can also specify a one-way 
> dynamic transition as well (type1_t can dynamically transition to type2_t, 
> but type2_t has no dynamic transitions available).  This will allow a 
> daemon process to initialize itself with one set of access rights (bind 
> ports, read conf files, etc.), and then lock itself into a domain with less 
> access rights for the duration of its execution.  

 i understand.

 in smbd's case, however, that would be detrimental: the flexibility of
 being able to transition back again [to type2_t] is actually a
 necessity.

 it might even be convenient to go through a "third" type:

 type1_t: access to samba configuration files [only!] seteuid: 0
 type2_t: access to user files [only!] seteuid: NNNN
 type3_t: access to pretty much nothing (except that needed for cleanup
          operations)

 the loop is type1_t, call become_user() -> goes to type2_t
 then call unbecome_user() -> transitions to type3_t and does cleanup
 (e.g. frees any alloc'd memory associated with user - if necessary)
 and then transitions to type1_t, ready for the next incoming SMB
 packet.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
