From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: RFC Fuzzing SE Linux interfaces
Date: Mon, 18 Jul 2016 17:07:33 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5601258B6E@ORSMSX103.amr.corp.intel.com>
References: <476DC76E7D1DF2438D32BFADF679FC56012586EE@ORSMSX103.amr.corp.intel.com>
 <2d10b437-22a0-15f8-d53f-b7c7adbcd4a5@tycho.nsa.gov>
In-Reply-To: <2d10b437-22a0-15f8-d53f-b7c7adbcd4a5@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Monday, July 18, 2016 6:21 AM
> To: Roberts, William C <william.c.roberts@intel.com>; selinux@tycho.nsa.gov
> Subject: Re: RFC Fuzzing SE Linux interfaces
> 
> On 07/15/2016 04:18 PM, Roberts, William C wrote:
> >
> >
> > A quick google search didn’t yield much, neither did a grep of the
> > selinux-testsuite, but is their currently any fuzzing work being done
> > on the selinux interfaces?
> 
> Not AFAIK.  There are general system call fuzzers for Linux such trinity and
> syzkaller; if you want to do full fledged fuzzing, you probably want to use one of
> those frameworks rather than rolling your own in selinux-testsuite.  On the other

I planned on using one of the frameworks, not sure which yet. I didn't plan on adding
Any fuzzing tests into selinux-testsuite. However, if I find issues, I'll likely take the malformed
Input and create a test case on that one, that way we can at least detect regressions on
Known bad inputs.

> hand, if you just want to write some specific tests of the selinuxfs and
> /proc/pid/attr interfaces and add them to selinux-testsuite, that's fine too.
> 
> > Also, I noticed that the test suite has some ToDo’s and I didn’t see
> > tests surrounding ioctlcmd there, are their some implemented?
> 
> Not implemented yet, but they are mentioned in the ToDo list:
> $ grep ioctl ToDo
> ioctl: Test new ioctl whitelisting feature.

IMHO we should probably not take new features without a tests.

> 
> You'll need Fedora 24 or newer in order to have the corresponding
> libsepol/checkpolicy support.
> 
