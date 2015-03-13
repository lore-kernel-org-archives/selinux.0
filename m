From: "Higgs, Stephen" <Stephen.Higgs@icfi.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: selinux category relabel (puppet)
Date: Fri, 13 Mar 2015 17:52:37 +0000
Message-ID: <103dc46dd5b34fa5a752edce40d20e01@VNUCITEX02.ICFI.icfconsulting.com>
References: <2409d98630af4bc39108524e04557017@VNUCITEX02.ICFI.icfconsulting.com>
 <55032105.1030903@tycho.nsa.gov>
In-Reply-To: <55032105.1030903@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> On 03/13/2015 09:52 AM, Higgs, Stephen wrote:
> > Hello all,
> >
> >
> >
> > If there is a more appropriate forum for this question please let me know:
> >
> >
> >
> > I have a system that uses confined users by default and some files are
> > managed by a puppet server.  When I run (via run_init) the puppet
> > startup script, I get the following avc log:
> >
> >
> >
> > avc: denied { relabelto } for pid=30707 comm="puppet" name="crl.pem"
> > dev=dm-1 ino=527257 scontext=system_u:system_r:puppet_t:s0
> > tcontext=system_u:object_r:puppet_var_lib_t:s0:c0.c1023 tclass=file
> >
> > I added "typeattribute puppet_t can_change_object_identity" and
> > appropriate "allow" statements to the puppet_t type after reading the
> > constraints in the targeted policy. However, it was the category
> > "s0:c0.c1023" that was also preventing puppet from relabeling the
> > crl.pem file.
> >
> > I was able to fix this by manually relabeling the file to "s0" instead
> > of "s0:c0.c1023". My question is, how *should* I handle this so puppet
> > can handle the relabel of the category?
> 
> It requires an appropriate attribute for the mcs or mls constraint that is
> blocking access.  Which attribute depends on your policy; MCS in particular has
> changed a lot over time in Fedora and RHEL.  What distro & version?
> 

I'm using CentOS / RedHat 6.6, targeted reference policy 24.
