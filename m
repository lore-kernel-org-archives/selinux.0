Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6HDMWht005147
 for <selinux@tycho.nsa.gov>; Sun, 17 Jul 2016 09:22:32 -0400
Received: by mail-oi0-f45.google.com with SMTP id l65so135457613oib.1
 for <selinux@tycho.nsa.gov>; Sun, 17 Jul 2016 06:22:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC56012586EE@ORSMSX103.amr.corp.intel.com>
References: <476DC76E7D1DF2438D32BFADF679FC56012586EE@ORSMSX103.amr.corp.intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 17 Jul 2016 09:22:01 -0400
Message-ID: <CAHC9VhTcq2u7Q6cJ95PuB-jfis5ZNzgpUv6dbAgZX9c_sdXjzw@mail.gmail.com>
Subject: Re: RFC Fuzzing SE Linux interfaces
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
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

On Fri, Jul 15, 2016 at 4:18 PM, Roberts, William C
<william.c.roberts@intel.com> wrote:
> A quick google search didn’t yield much, neither did a grep of the
> selinux-testsuite, but is their currently any fuzzing work being done on the
> selinux interfaces?

I'm not aware of any.

> Also, I noticed that the test suite has some ToDo’s and I didn’t see tests
> surrounding ioctlcmd there, are their some implemented?

Not that I'm aware of at the moment, perhaps the SEAndroid folks have
some?  I think the initial problem was that the new ioctl xperms
didn't play well with modular policy, although I believe that has now
been fixed.  If you've got the time to write some tests, I'd love to
have them in the testsuite.

-- 
paul moore
www.paul-moore.com
