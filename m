From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "jdanis@google.com" <jdanis@google.com>
Subject: RE: [RFC] mmap file_contexts and property_contexts:
Date: Tue, 20 Sep 2016 21:21:32 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD0D8B2@ORSMSX103.amr.corp.intel.com>
References: <1474321526-26208-1-git-send-email-william.c.roberts@intel.com>
 <476DC76E7D1DF2438D32BFADF679FC561CD0B1D9@ORSMSX103.amr.corp.intel.com>
 <6891e2bf-ef16-d10a-d789-36f6576efacb@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> > On 09/19/2016 05:51 PM, Roberts, William C wrote:
> > > FYI I only tested this with checkfc...
> >
> > Evidently.  matchpathcon and sefcontext_compile both report calls to
> > free() on invalid pointers and abort.
> 
> That doesn’t surprise me, I only tested the checkfc usages. Hence #4 in todo's
> 

I looked at the sefcontext_compile bug, and its yet another conglomeration where internal
Interfaces into libselinux are presumed and duplicate code exists (for loading a file).
It implements its own routine for the freeing of Spec data. Why doesn't it use proper
libselinux interfaces, or libselinux expose the proper Interfaces for this type of work?
Is this just an example of something that should be fixed or is there some deeper
reasoning to its construction?

I could not get matchpatchcon to reproduce (built with ASAN):
./selinux/libselinux/utils/matchpathcon /etc -f file_contexts
/etc	u:object_r:rootfs:s0

Bill
