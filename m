Date: Wed, 1 Sep 2004 09:23:42 -0500 (CDT)
From: Richard Troth <rtroth@bmc.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Nigel Kukard <nkukard@lbsd.net>, linux-hotplug-devel@lists.sourceforge.net,
   SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [OT] SELinux vs. other systems [was Re: [idea] udev + selinux]
In-Reply-To: <20040831224447.GA4964@austin.ibm.com>
Message-ID: <Pine.LNX.4.53.0409010904530.7518@rmt-desk.bmc.com>
References: <20040831224447.GA4964@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 31 Aug 2004, Linas Vepstas wrote:
> Every now and then, I look at SELinux, and I get scared away by its
> complexity.  This complexity makes it very hard to audit, and assure
> oneself that its actually providing any real security, as opposed to
> the illusion of security.   ...

Tough questions.   Good questions!
Still,  I do believe MAC has value in contrast to DAC.
But the opposing "flying buttress" to this is that it all
boils down to binary ... somewhere.   And is THAT part isolated?

> Compare this to less complex security provided by e.g. the Linux
> VServer project.  VServer is intended to allow an ISP to pretend they
> have a rack of 100 cpu's all running linux, when in fact they have just
> one.  The fact that it provides security is a side-effect; but its
> far simpler, far easier to audit, and allows me to sleep at night.

Ahhh...   virtual machines.   (And I don't mean Java.)
I'm thinking VMware and (esp) z/VM (IBM style mainframe).
Been using both or years,  VMware since 1.0 beta and mainframe since ...
well ... I was pretty young at the time.   But not for security per-se,
they have other interesting features.   Linas' mention of VServer
and its side-effect security reminds me of something I read
in the anals of VM hisory:

	http://vm.marist.edu/~vmshare/browse?fn=VMHIST07&ft=NOTE

(Stephen, Howard, and the rest and friends at the NSA
please take no offense.   I found this terribly entertaining.)
Even from its earliest days,  VM (CP) isolated each user,  so:

        "On another  occasion we almost  had an  in-house protest.
         Among the early  users of CP-67/CMS were  both the National
         Security Agency and the CIA;  the fact that the DAT hardware
         isolated each user in his own  address space was viewed as a
         powerful system security feature.   One  time in 1970,  I
         think, the CIA sent two of their people to Cambridge to talk
         about something  that Ed Hendricks  had developed  or was
         working on.   In the atmosphere of  the time,  none of the
         technical people at CSC,  especially Ed,  wanted to talk to
         them at all!   Ed stormed around the halls muttering "damned
         spooks!" for half an hour or  more before Craig Johnson and
         Norm Rasmussen were  able to coerce him  into the meeting.
         Even more amazing is that they were spooks;  there was a man
         and a woman, both of slightly below-average height,  average
         build,  average  everything!   You could stand  and talk
         directly to them or study them for five minutes or more, but
         if you  turned around there  was nothing to  remember and
         nothing to describe; they were effectively invisible."

Thanks to Lynn Wheeler for helping me dig this up.

-- R;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
