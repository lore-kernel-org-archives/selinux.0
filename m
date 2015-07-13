Date: Mon, 13 Jul 2015 14:34:23 -0400 (EDT)
From: Robert Kuska <rkuska@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1482209083.32107040.1436812463571.JavaMail.zimbra@redhat.com>
In-Reply-To: <55A3CB1A.5050001@tycho.nsa.gov>
References: <1083792539.31969453.1436795740226.JavaMail.zimbra@redhat.com>
 <55A3CB1A.5050001@tycho.nsa.gov>
Subject: Re: [PATCH] sepolgen: add support for python3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: "Stephen Smalley" <sds@tycho.nsa.gov>
> To: "Robert Kuska" <rkuska@redhat.com>, selinux@tycho.nsa.gov
> Sent: Monday, July 13, 2015 4:28:42 PM
> Subject: Re: [PATCH] sepolgen: add support for python3
> 
> On 07/13/2015 09:55 AM, Robert Kuska wrote:
> > Hello everyone,
> > 
> > this is my first mail to this mailing list so I would like to
> > introduce myself a bit.
> > 
> > I am Robert Kuska, member of python-sig in Fedora and co-owner
> > of change Python3 as default. In Fedora many packages depends
> > on policycoreutils which ships python modules from selinux, the
> > problem is (at least for us as we want to have default installation
> > clean of Python2) that not all of them work with Python3. Therefore
> > I've decided to make a patch(es) for all modules (except for GUI)
> > to make them work with python3.
> > 
> > As a first I've picked a sepolgen as it seemed it will be the hardest.
> > Please note that I have no previous experience with coding for selinux
> > project.
> > 
> > You can find my patch as an attachment to this mail, as it is a rather
> > big one (I didn't split the patch because it fixes mostly same syntax
> > errors).
> > 
> > I have tested the patch with python2.7 and python3.4. I had
> > no issue with python2.7 except for test_module.TestModuleCompiler.test
> > which was failing even before my patch.
> 
> Do you have selinux-policy-devel installed?

My bad, after installing the devel package all tests pass (on python2).

Thank you.

> 
> > 
> > Following failures (number vary, from 1 to 6) were seen with python3.4:
> > 
> > https://paste.fedoraproject.org/243817/36795382/
> > 
> > The origin of these failures lies within change in hash function of sets
> > and dicts, hash now uses random seed in python3 and tests rely on
> > frozen order of items which is imho bad. I didn't fix those tests
> > as I wanted to know firstly if this is just a issue with tests and such
> > frozen order is not expected.
> 
> I didn't write sepolgen, but it is certainly the case that the order in
> which permissions or types are listed in a policy rule makes no
> difference to its semantics.

Jason Zaman said the same thing on irc, I just wanted to be sure, I can send
another patch with fixed tests.

> 
> 
> 



--
Robert Kuska
{rkuska}
