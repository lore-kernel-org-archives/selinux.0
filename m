Subject: Re: Of applications and separating configuration systems
From: Karl MacMillan <kmacmillan@tresys.com>
To: russell@coker.com.au
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <200402141521.49027.russell@coker.com.au>
References: <20040214000922.GA1083@gallifrey>
	 <200402141521.49027.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1077028128.15096.68.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Tue, 17 Feb 2004 09:28:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-13 at 23:21, Russell Coker wrote:
> > Is it easy to set such a system up?  What about allowing normal users
> > to see the policy violations that are causing their individual programs
> > are making?
> 
> This is not really possible at the moment.  Allowing all users to see all 
> messages is easy but usually not desirable.  Writing a program to sort 
> through the syslogd output and make some of the messages involving a user's 
> account available to them would be possible, but no-one has worked on it 
> AFAIK.

Though we are not working directly on this problem, our audit analysis
tool seaudit has much of the needed infrastructure to support this.
Additionally, all of the syslog parsing, filtering, and sorting
functionality for seaudit is packaged as a separate library (look in
libseaudit in the setools distribution).

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
