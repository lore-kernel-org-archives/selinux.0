Subject: Re: Se-Linux Updates for LTP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: subrata@linux.vnet.ibm.com
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
        ltp-list <ltp-list@lists.sourceforge.net>,
        George Kraft <gk4@us.ibm.com>,
        Ricardo Salveti de Araujo <rsalveti@linux.vnet.ibm.com>,
        klausk@br.ibm.com, Joy Latten <latten@us.ibm.com>
In-Reply-To: <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com>
	 <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 09:01:09 -0500
Message-Id: <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-10 at 11:31 +0530, Subrata Modak wrote:
> On Fri, 2007-12-07 at 21:55 +0530, Subrata Modak wrote:
> > Hi All,
> > 
> > Today i had the opportunity to meet James Morris from Red Hat at FOSS.in
> > held at Bangalore, India. After his talks on Se-Linux, we were
> > discussing about the Policy Reference support for Se-linux available in
> > LTP under the directory:
> > ltp/testcases/kernel/security/selinux-testsuite/
> > 
> > Though i have released RHEL5 EAL4+ Certification Testsuites from IBM, i
> > have not seen the testcases under:
> > ltp/testcases/kernel/security/selinux-testsuite/
> > updated for more than an year. I am not aware exactly about the reason
> > for the same. I would like to request you send me any updates that you
> > may want to give to LTP for your selinux-testsuite.
> 
> Can somebody give me some direction on this ??

What kind of direction are you seeking?

We gave the selinux testsuite to IBM at their request, and they ported
it over to the LTP and submitted it there.  Joy Latten was involved in
the porting; I've cc'd her above.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
