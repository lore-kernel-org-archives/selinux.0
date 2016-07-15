Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FJZo1d014698
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 15:35:50 -0400
Received: by mail-oi0-f50.google.com with SMTP id j185so171082796oih.0
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 12:35:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC56012585A7@ORSMSX103.amr.corp.intel.com>
References: <1468524562-30981-1-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhReO7tLcB=K6KbGpH_inzMCLVLHmYWibNFGVku27Y=kFw@mail.gmail.com>
 <1613578.6STCXkp1CU@x2>
 <476DC76E7D1DF2438D32BFADF679FC56012585A7@ORSMSX103.amr.corp.intel.com>
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 15 Jul 2016 15:35:48 -0400
Message-ID: <CAGH-KgtTjeQqBFGx6BFB0u-fkdphaxH+3nrUwZf0HfNKUn8bfQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: print leading 0x on ioctlcmd audits
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-audit@redhat.com" <linux-audit@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Fri, Jul 15, 2016 at 3:31 PM, Roberts, William C
<william.c.roberts@intel.com> wrote:
> Does this mean then the patch will be applied?

As I mentioned earlier, I added it to the SELinux next queue, as soon
as the merge window closes (approx two weeks from this weekend) I will
rotate the patch into the SELinux next branch.

-- 
paul moore
security @ redhat
