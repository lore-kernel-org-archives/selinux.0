Date: Sun, 19 Apr 2009 20:32:43 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, ltp-list <ltp-list@lists.sf.net>,
        SE Linux <selinux@tycho.nsa.gov>, Jiri Palecek <jpalecek@web.de>
Subject: Re: [LTP] Fwd:  [PATCH] Create $SELINUXTMPDIR in each of the tests
Message-ID: <20090420013243.GB20228@us.ibm.com>
References: <1240080458.5108.18.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240080458.5108.18.camel@subratamodak.linux.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> Stephen,
> 
> Would you like to say something about the following Patch ?

If the motivation is to support multiple concurrent ltp runs, wouldn't
it be better to have selinux-testsuite/tests/runtest.sh set/export
SELINUXTMPDIR to a per-run tempdir?  Even as simple as
/tmp/selinux-$pid.

Well, and testscripts/test_selinux.sh I guess...

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
