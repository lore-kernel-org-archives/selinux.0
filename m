Message-ID: <4AC25AAA.8010108@redhat.com>
Date: Tue, 29 Sep 2009 15:06:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Orion Poplawski <orion@cora.nwra.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SElinux troubles
References: <4AB10AC9.9020006@cora.nwra.com> <4AB1125E.3020402@redhat.com>	 <4AB119F1.4070600@cora.nwra.com> <4AB12199.5090901@redhat.com>	 <4AB7BC55.4060304@cora.nwra.com> <4AB83734.6090805@redhat.com>	 <4AB8DE44.3090907@cora.nwra.com> <4AB8E96D.50801@redhat.com>	 <4AB8F20A.5040409@cora.nwra.com> <4AC1087C.2090800@redhat.com>	 <4AC118EC.6090707@cora.nwra.com>  <4AC119D3.5070107@redhat.com>	 <1254169373.14478.191.camel@moss-pluto.epoch.ncsc.mil>	 <4AC12227.1070006@cora.nwra.com> <1254225540.2252.6.camel@moss-pluto.epoch.ncsc.mil> <4AC21A88.1020109@cora.nwra.com>
In-Reply-To: <4AC21A88.1020109@cora.nwra.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/29/2009 10:32 AM, Orion Poplawski wrote:
> On 09/29/2009 05:59 AM, Stephen Smalley wrote:
>> Do you get any avc denial in /var/log/audit/audit.log
>> or /var/log/messages?  If so, what does audit2why say about it?
> 
> No denial messages.
> 
Any chance you have an acl set on this directory or Immutable

lsattr /etc/ssh


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
