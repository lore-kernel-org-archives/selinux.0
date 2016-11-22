Message-ID: <1479828936.4919.2.camel@btinternet.com>
Subject: Re: github issue trackers
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-NSA <SELinux@tycho.nsa.gov>,
 linux-sctp@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Nov 2016 15:35:36 +0000
In-Reply-To: <b54fe273-01bf-e128-0dcc-5fb764f865f8@tycho.nsa.gov>
References: <74821043-5051-f05b-9ef8-e34af08f7a54@tycho.nsa.gov>
 <1479487762.13487.6.camel@btinternet.com>
 <b54fe273-01bf-e128-0dcc-5fb764f865f8@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2016-11-18 at 12:02 -0500, Stephen Smalley wrote:
> On 11/18/2016 11:49 AM, Richard Haines wrote:
> > 
> > On Fri, 2016-11-18 at 10:30 -0500, Stephen Smalley wrote:
> > > 
> > > Hi,
> > > 
> > > I've populated the github issue trackers for the selinux
> > > (userspace)
> > > and
> > > selinux-kernel github projects, see:
> > > https://github.com/SELinuxProject/selinux/issues
> > > and
> > > https://github.com/SELinuxProject/selinux-kernel/issues
> > > 
> > > The old ToDo wiki pages are being migrated over, although I would
> > > like
> > > to drop items that are either a) already in progress, b)
> > > vague/ill-defined, or c) unlikely to be done.  Going forward,
> > > we'll
> > > just
> > > use the issue trackers for all new items.
> > > 
> > > Feel free to identify additional issues that I may have missed,
> > > but
> > > please try to keep them well-defined and feasible.
> > 
> > Just thought I would update you regarding the status of the RFC
> > SCTP
> > kernel patches I sent a few years ago that are referenced at:
> > https://github.com/SELinuxProject/selinux-kernel/issues/5
> > 
> > I have been keeping these updated and fixing problems as I find
> > them,
> > however I have not resubmitted. If there is interest I'm happy to
> > submit again and see how far I can get. If anyone is interested
> > I keep a set of patches at:
> > http://arctic.selinuxproject.org/~rhaines/selinux-sctp
> > 
> > For the gory details read:
> > http://arctic.selinuxproject.org/~rhaines/selinux-sctp/readme.txt
> 
> Thanks, I'd certainly like to see them upstreamed.  Were there
> specific
> objections or just a lack of response?

It was really lack of response so I thought I would wait until
someone had a real requirement. Paul gave me some feedback on the
patches and I incorporated all except the "special accept()/child
socket labeling trick" (see comments at 
http://marc.info/?l=selinux&m=141801137004870&w=2), mainly because
I was not sure if required or not.
Also needed feedback from sctp maintainers particularly regarding
the placing of security hooks in sm_statefuns.c (see the drawing in
SELinux-sctp.txt)

What I can do is rebuild and test on latest Fedora 25 then submit
again as a new RFC patch and see how it goes.

> 
> 
