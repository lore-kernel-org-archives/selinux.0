From: Steve Grubb <sgrubb@redhat.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Subject: Re: [RFC PATCH] newrole suid breakdown
Date: Fri, 6 Oct 2006 11:36:57 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
References: <452432FA.1060009@us.ibm.com> <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil> <452674C8.2040105@us.ibm.com>
In-Reply-To: <452674C8.2040105@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610061136.57785.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 06 October 2006 11:22, Michael C Thompson wrote:
> If someone can also confirm this behavior, this could be the solution
> we're looking for. 

Have you checked it with and without selinux enabled? Besides, why can't you 
just check the capabilities?

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
