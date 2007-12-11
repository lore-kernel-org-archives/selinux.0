Subject: Re: [LTP] Se-Linux Updates for LTP
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
        George Kraft <gk4@us.ibm.com>, klausk@br.ibm.com,
        ltp-list <ltp-list@lists.sourceforge.net>,
        SE Linux <selinux@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        Robert Williamson <robbiew@us.ibm.com>, Paul Larson <plars@us.ibm.com>,
        Michael Reed <mreed10@us.ibm.com>
In-Reply-To: <20071210171503.GA25223@sergelap.austin.ibm.com>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com>
	 <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
	 <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20071210171503.GA25223@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Dec 2007 19:52:49 +0530
Message-Id: <1197382969.9034.29.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-10 at 11:15 -0600, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > On Mon, 2007-12-10 at 11:31 +0530, Subrata Modak wrote:
> > > On Fri, 2007-12-07 at 21:55 +0530, Subrata Modak wrote:
> > > > Hi All,
> > > > 
> > > > Today i had the opportunity to meet James Morris from Red Hat at FOSS.in
> > > > held at Bangalore, India. After his talks on Se-Linux, we were
> > > > discussing about the Policy Reference support for Se-linux available in
> > > > LTP under the directory:
> > > > ltp/testcases/kernel/security/selinux-testsuite/
> > > > 
> > > > Though i have released RHEL5 EAL4+ Certification Testsuites from IBM, i
> > > > have not seen the testcases under:
> > > > ltp/testcases/kernel/security/selinux-testsuite/
> > > > updated for more than an year. I am not aware exactly about the reason
> > > > for the same. I would like to request you send me any updates that you
> > > > may want to give to LTP for your selinux-testsuite.
> > > 
> > > Can somebody give me some direction on this ??
> > 
> > What kind of direction are you seeking?
> > 
> > We gave the selinux testsuite to IBM at their request, and they ported
> > it over to the LTP and submitted it there.  Joy Latten was involved in
> > the porting; I've cc'd her above.

Well i have not received any selinux testcases updates for reference
policy for the last 3 quarters. What i have received and released is  
EAL4+ Certification Test Suite, which includes
rhel5_ibm_eal4_cert_suite2.tgz. I drilled down in to this and tried to
find whether there are any se-linux testcases included here, which are
apparently present in ltp/testcases/kernel/security/selinux-testsuite/
directory of ltp-full-20073011.tgz (can be downloaded from
http://prdownloads.sourceforge.net/ltp/ltp-full-20071130.tgz?download).
I did not find either of them. They seemed different to me. 

> 
> So the question is who should update the testsuite.  This is not just an
> issue for selinux, but for all the ltp tests.
> 
> One could say it's Joy because she submitted the testcases.  But let me
> warn you that that attitude will definitely decrease the likelyhood of
> testcases being submitted to LTP.  (It'll certainly deter me)
> 
> One could say it should be the selinux community in general, but that
> community is too large for such an answer to be helpful, and it may not
> be fair since they can say "we didn't submit that."
> 
> One could say it should be the reference policy maintainer, because I
> suspect refpolicy updates will be the biggest cause of breakage - but
> that isn't fair to him since again he didn't submit it.
> 
> One might say it should be the ltp community - after the biggest
> advantage of submitting to LTP should be some free maintenance.  However
> it likely doesn't have the needed expertise.

Ok. This is i would say as a collective responsibility rather than
somebodyś alone. It is the responsibility of the maintainer (here LTP
and hence myself) to find out the validity of test cases in his/her
project he/she is maintaining, and, then try to contact the author(s) of
that particular test case component to provide updates if even he/she
(Author(s)) has the updates themselves. Now it is upto their (Author(s))
interest to write back if they are interested. Else the Maintainer is
helpless.
I initiated this mail as i found it my responsibility to find out
authors who actually wrote these reference policy test cases for
se-linux, and which are part of LTP in
ltp/testcases/kernel/security/selinux-testsuite/ directory. Now if the
author(s) respond, then i would work hard to integrate the same.
After interaction with James Morris at FOSS.in, Bangalore, India, i came
to know that he is also working on se-linux and he mentioned about the
presence of reference policy support in LTP. I pointed him the release
that i made this year (EAL4+ Certification Test Suite) and also
requested him whether he can update me on the se-linux reference policy
test cases of se-linux available inside Main LTP, he pointed me to write
to se-linux test suite mailing list. Hence this mail. 

Now i myself has never executed these test case, so not aware of them
much. But that should not prevent me from requesting updates of the
same. I would be extremely happy even if we can reach the final updates
through some pointer-to-pointer and that will serve my purpose of having
all updates in LTP.

Just to cite an example, i recently found out that there are updates
being made to pounder21 test suite(present inside LTP), by somebody for
his/her internal project use. Now, the same has never been updated in
LTP for quite long time. I immediately mailed to him requesting him for
updates. Now my purpose will be served if i get updates from him, let
alone it comes to me after long time is not the question.

> 
> Anyway I think there is value to having the selinux testsuite.  Though
> one problem with having it in LTP is that most LTP runs are done on
> machines which are not set up right for selinux.  I personally haven't
> had enough potential target machines to be able to run the tests
> regularly.  So I don't even know whether anyone has run
> ltp/testcases/kernel/security/selinux-testsuite/ in the last year.  Joy
> might know though.
> 
> So given that I personally don't know who to pin down, and given that I
> don't have time to maintain the testsuite by myself, if I could get two
> or three other people to volunteer to help out, I wouldn't mind being
> part of a group responsible for the maintenance.
> 
> For starters, I finally have a fedora 8 vm set up which once I'm done
> with another test i can use to try out the existing testsuite.
> Hopefully that'll be later this week (no guarantees).  I'll report on
> the results.
> 
> -serge

Thanks Serge. Will wait for your results.

Regards--
Subrata


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
