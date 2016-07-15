From: Steve Grubb <sgrubb@redhat.com>
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Paul Moore <pmoore@redhat.com>, William Roberts <bill.c.roberts@gmail.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-audit@redhat.com" <linux-audit@redhat.com>
Subject: Re: [PATCH] selinux: print leading 0x on ioctlcmd audits
Date: Fri, 15 Jul 2016 15:41:37 -0400
Message-ID: <3333447.I3SejC0nv6@x2>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC56012585BF@ORSMSX103.amr.corp.intel.com>
References: <1468524562-30981-1-git-send-email-william.c.roberts@intel.com>
 <CAGH-Kgsx9a21PbypubWH0yYNkRq3fPb6mxB1fyV1yeTb-=yDVg@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC56012585BF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Friday, July 15, 2016 7:33:09 PM EDT Roberts, William C wrote:
> <snip>
> 
> > > This is important so that people don't make up new ones that do the
> > > same thing. The ioctlcmd field name should be recorded. Are there more
> > > that need documenting?
> > 
> > Steve/William, one of you want to send a patch/PR for the field
> > dictionary?
> 
> I'll send it over.

I also asked some other questions.  Is this the ioctl number? As in syscall 
arg a1? I need to know if its the same thing so that I can hook up its 
translation if so.

Thanks,
-Steve
