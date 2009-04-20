Date: Mon, 20 Apr 2009 08:36:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: =?utf-8?B?SmnFmcOtIFBhbGXEjWVr?= <jpalecek@web.de>
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, ltp-list <ltp-list@lists.sf.net>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [LTP] Fwd:  [PATCH] Create $SELINUXTMPDIR in each of the tests
Message-ID: <20090420133612.GB603@us.ibm.com>
References: <1240080458.5108.18.camel@subratamodak.linux.ibm.com> <20090420013243.GB20228@us.ibm.com> <op.usoj4f1cu2flwt@marcela-gaxm89c>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <op.usoj4f1cu2flwt@marcela-gaxm89c>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Jiří Paleček (jpalecek@web.de):
> On Mon, 20 Apr 2009 03:32:43 +0200, Serge E. Hallyn <serue@us.ibm.com> wrote:
> 
> > Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> >> Stephen,
> >>
> >> Would you like to say something about the following Patch ?
> >
> > If the motivation is to support multiple concurrent ltp runs, wouldn't
> > it be better to have selinux-testsuite/tests/runtest.sh set/export
> > SELINUXTMPDIR to a per-run tempdir?  Even as simple as
> > /tmp/selinux-$pid.
> 
> No, the motivation was mostly to allow running these tests directly from PAN, without any supporting scripts. The ability to run the tests concurrently is just a pleasant bonus. I chose this way, because I find the needed changes pretty small.

Yeah - seems like a good idea.

If the directories sometimes don't get deleted, then you might help out
the admin by giving the directories easy to spot names so they can
manually clean up...  i.e. use mktemp -d /tmp/ltpselinuxXXXX or maybe
even better mkdir -p /tmp/ltpselinux; mktemp -d -p /tmp/ltpselinux

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
