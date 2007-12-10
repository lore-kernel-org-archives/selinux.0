Date: Mon, 10 Dec 2007 11:15:03 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: subrata@linux.vnet.ibm.com, James Morris <jmorris@redhat.com>,
        George Kraft <gk4@us.ibm.com>, klausk@br.ibm.com,
        ltp-list <ltp-list@lists.sourceforge.net>,
        SE Linux <selinux@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>
Subject: Re: [LTP] Se-Linux Updates for LTP
Message-ID: <20071210171503.GA25223@sergelap.austin.ibm.com>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com> <1197266491.4482.2.camel@subratamodak.linux.ibm.com> <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Mon, 2007-12-10 at 11:31 +0530, Subrata Modak wrote:
> > On Fri, 2007-12-07 at 21:55 +0530, Subrata Modak wrote:
> > > Hi All,
> > > 
> > > Today i had the opportunity to meet James Morris from Red Hat at FOSS.in
> > > held at Bangalore, India. After his talks on Se-Linux, we were
> > > discussing about the Policy Reference support for Se-linux available in
> > > LTP under the directory:
> > > ltp/testcases/kernel/security/selinux-testsuite/
> > > 
> > > Though i have released RHEL5 EAL4+ Certification Testsuites from IBM, i
> > > have not seen the testcases under:
> > > ltp/testcases/kernel/security/selinux-testsuite/
> > > updated for more than an year. I am not aware exactly about the reason
> > > for the same. I would like to request you send me any updates that you
> > > may want to give to LTP for your selinux-testsuite.
> > 
> > Can somebody give me some direction on this ??
> 
> What kind of direction are you seeking?
> 
> We gave the selinux testsuite to IBM at their request, and they ported
> it over to the LTP and submitted it there.  Joy Latten was involved in
> the porting; I've cc'd her above.

So the question is who should update the testsuite.  This is not just an
issue for selinux, but for all the ltp tests.

One could say it's Joy because she submitted the testcases.  But let me
warn you that that attitude will definitely decrease the likelyhood of
testcases being submitted to LTP.  (It'll certainly deter me)

One could say it should be the selinux community in general, but that
community is too large for such an answer to be helpful, and it may not
be fair since they can say "we didn't submit that."

One could say it should be the reference policy maintainer, because I
suspect refpolicy updates will be the biggest cause of breakage - but
that isn't fair to him since again he didn't submit it.

One might say it should be the ltp community - after the biggest
advantage of submitting to LTP should be some free maintenance.  However
it likely doesn't have the needed expertise.

Anyway I think there is value to having the selinux testsuite.  Though
one problem with having it in LTP is that most LTP runs are done on
machines which are not set up right for selinux.  I personally haven't
had enough potential target machines to be able to run the tests
regularly.  So I don't even know whether anyone has run
ltp/testcases/kernel/security/selinux-testsuite/ in the last year.  Joy
might know though.

So given that I personally don't know who to pin down, and given that I
don't have time to maintain the testsuite by myself, if I could get two
or three other people to volunteer to help out, I wouldn't mind being
part of a group responsible for the maintenance.

For starters, I finally have a fedora 8 vm set up which once I'm done
with another test i can use to try out the existing testsuite.
Hopefully that'll be later this week (no guarantees).  I'll report on
the results.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
