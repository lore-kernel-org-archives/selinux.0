Subject: Re: RFC Fuzzing SE Linux interfaces
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC56012586EE@ORSMSX103.amr.corp.intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2d10b437-22a0-15f8-d53f-b7c7adbcd4a5@tycho.nsa.gov>
Date: Mon, 18 Jul 2016 09:21:18 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC56012586EE@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 07/15/2016 04:18 PM, Roberts, William C wrote:
>  
> 
> A quick google search didn’t yield much, neither did a grep of the
> selinux-testsuite, but is their currently any fuzzing work being done on
> the selinux interfaces?

Not AFAIK.  There are general system call fuzzers for Linux such trinity
and syzkaller; if you want to do full fledged fuzzing, you probably want
to use one of those frameworks rather than rolling your own in
selinux-testsuite.  On the other hand, if you just want to write some
specific tests of the selinuxfs and /proc/pid/attr interfaces and add
them to selinux-testsuite, that's fine too.

> Also, I noticed that the test suite has some ToDo’s and I didn’t see
> tests surrounding ioctlcmd there, are their some implemented?

Not implemented yet, but they are mentioned in the ToDo list:
$ grep ioctl ToDo
ioctl: Test new ioctl whitelisting feature.

You'll need Fedora 24 or newer in order to have the corresponding
libsepol/checkpolicy support.
