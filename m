Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Mark Goldman <mgoldman@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <467BFF99.9000404@tycho.nsa.gov>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
	 <1180017921.2940.24.camel@localhost.localdomain>
	 <1180034401.3930.203.camel@tresys-winxppro>
	 <1180108369.6331.18.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com>
	 <1180137749.10334.18.camel@localhost.localdomain>
	 <4677F1BC.2000201@tresys.com>
	 <1182443353.11527.50.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>
	 <1182449086.11527.80.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com>
	 <1182449898.11527.83.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com>
	 <1182450900.11527.88.camel@localhost.localdomain>
	 <467AE59E.2050501@tycho.nsa.gov>
	 <1182525734.3014.20.camel@localhost.localdomain>
	 <467BFF99.9000404@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 15:30:24 -0400
Message-Id: <1182540624.6599.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-22 at 12:58 -0400, Eamon Walsh wrote:
> Karl MacMillan wrote:
> > On Thu, 2007-06-21 at 16:54 -0400, Eamon Walsh wrote:
> > 
> >>   I'm not a fan of the Python dependencies.
> >>
> > 
> > Why?
> 
> Here's a nice example of RPM hell, courtesy of our Python dependency.  I 
> got this earlier in the year on one of my machines.
> 
> 
> # yum -y upgrade
> --> Running transaction check
> --> Processing Dependency: gnutls-devel for package: libsoup-devel
> --> Processing Dependency: python(abi) = 2.4 for package: audit-libs-python
> --> Restarting Dependency Resolution with new changes.
> --> Populating transaction set with selected packages. Please wait.
> ---> Package gnutls-devel.i386 0:1.4.5-1 set to be updated
> --> Running transaction check
> --> Processing Dependency: python(abi) = 2.4 for package: audit-libs-python
> --> Finished Dependency Resolution
> Error: Missing Dependency: python(abi) = 2.4 is needed by package 
> audit-libs-python
> 

Rawhide or a release? Was this during the move to 2.5?

Larger issue, though, is that any dependency could cause the same
problem. I'm not convinced that what was likely a packaging error or yum
error should prevent us from using the best tools for the job.

Again: I'm not totally against this. I'm just very concerned about the
potential for problems in this code and the initial implementation
confirmed all of those concerns. Is it possible to get this code correct
in C? Sure. Is it likely for it to be correct initially and stay that
way is the question.

Can I suggest a middle ground? Implement in C (or C++) but use a string
library.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
