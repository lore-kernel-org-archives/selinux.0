Date: Wed, 21 Apr 2004 22:56:59 -0500
From: Tom Brown <tdbrown@uiuc.edu>
To: Dale Amon <amon@vnl.com>
Cc: Ed Street <edstreet@street-tek.com>, SELinux@tycho.nsa.gov,
   "'Michael Ihde'" <ihde@uiuc.edu>
Subject: Re: SELinux security in the face of single bit errors
Message-ID: <20040422035659.GQ731@peach.ece.utexas.edu>
References: <20040415231659.GG4773@peach.ece.utexas.edu> <20040416124423.1858C3A404F@abyss.simplyaquatics.com> <20040416184516.GV4773@peach.ece.utexas.edu> <20040417112213.GE21171@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040417112213.GE21171@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Apr 17, 2004 at 12:22:13PM +0100, Dale Amon wrote:
> On Fri, Apr 16, 2004 at 01:45:16PM -0500, Tom Brown wrote:
> > We are most interested in how single-bit errors affect security software
> > in general, rather than the protection of some specific software. If
> > we continue the project beyond this semester (likely if initial results
> > offer some hope) we may branch out to look at more than basic SELinux.
> 
> Just curious. Is this a study of the effect of SEU's 
> in spacecraft hardware? 

Not specifically. SEU's are more likely in space but they do occur in
terrestrial systems. I believe SEU's can be encouraged by a solar
radiation storm or simple heat[1]. We want to see at what rate they
might create security problems.

Tom

[1] "Using Memory Errors to Attack a Virtual Machine", Sudhakar
Govindavajhala, Andrew W. Appel

-- 
28 70 20 71 2C 65 29 61 9C B1 36 3D D4 69 CE 62 4A 22 8B 0E DC 3E
mailto:tdbrown@uiuc.edu
http://thecap.org/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
