Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7NDoecu025663
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 09:50:40 -0400
Received: from workstation.fluency.net.uk ([185.34.9.224]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0LufbI-1bBtln2KRM-00zotl for
 <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 15:50:31 +0200
Date: Tue, 23 Aug 2016 14:50:27 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] genhomedircon: add support for %group syntax
Message-ID: <20160823135027.GB21631@workstation.fluency.net.uk>
References: <1471897381-21216-1-git-send-email-gary.tierney@gmx.com>
 <a0946bf4-e061-7298-fe4f-2a51345f612e@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a0946bf4-e061-7298-fe4f-2a51345f612e@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 23, 2016 at 08:54:17AM -0400, Stephen Smalley wrote:
> On 08/22/2016 04:22 PM, Gary Tierney wrote:
> > From: Gary Tierney <selinux@tycho.nsa.gov>
> > 
> > Re-spin of my original patch that adds support for logins mapped using the
> > group %syntax to genhomedircon.  This version includes fixes for the issues
> > raised by Jason and splits the bugfix into a separate commit.
> > 
> > There was a bit of confusion about the MLS level, I think, since semanage-user
> > supports a default MLS level and not semanage-login.  So it wouldn't be possible
> > for a login to have a more specific level than the fallback login in that case.
> > Though the bugfix still addresses an issue with home directories outside of
> > /home / LU_HOMEDIRCETORY and is required for the second commit.
> 
> semanage login can set a more limited range for a Linux user than what
> is allowed for the SELinux user.  Thus, you can have a single SELinux
> user that is authorized for a wider range but narrow its scope on a
> per-Linux-user basis via semanage login.
> 
> > 
> > Gary Tierney (2):
> >   genhomedircon: generate contexts for logins mapped to the default user
> >   genhomedircon: add support for %group syntax
> > 
> >  libsemanage/src/genhomedircon.c | 314 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 243 insertions(+), 71 deletions(-)
> > 
> 

Yes, it's possible for a more specific range, and not level.  Though, the                                                            
current behavior of genhomedircon is to replace any instance of "s0" with the                                                        
users (semanage-user) level.  Should the range of the login be used here instead?                                                    
I'm unsure about this.                                                                                                               
                                                                                                                                     
Also, there's an identical v3 of this patch above to get rid of the erroneous                                                        
committer / signed-off-by / author information in this patch.  Sorry about                                                           
that.

-- 
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=get&search=0x706ED76585AA79D8
