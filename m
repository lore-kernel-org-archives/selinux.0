Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RClHvo004814
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 08:47:17 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RChIcj011273
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 12:43:19 GMT
Message-ID: <49CCCAD0.5010607@redhat.com>
Date: Fri, 27 Mar 2009 08:47:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Jan-Frode Myklebust <janfrode@tanso.net>, selinux@tycho.nsa.gov
Subject: Re: [Fwd: [idea] web-application security powered by SELinux]
References: <49C98427.8080300@ak.jp.nec.com> <20090326102256.GA1353@janfrode.ibm.com> <49CC3DD0.2000202@ak.jp.nec.com>
In-Reply-To: <49CC3DD0.2000202@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/26/2009 10:45 PM, KaiGai Kohei wrote:
> Jan-Frode Myklebust wrote:
>> On Wed, Mar 25, 2009 at 10:08:55AM +0900, KaiGai Kohei wrote:
>>> One idea is to add a security focused MPM which provide above features
>>> and hooks for external modules.
>>> I've actually developed a working example based on the "prefork" MPM.
>>> When it accepts a request from the client, it creates a one-time thread
>>> and assigns a new security context (which is a privileges set in SELinux),
>>> then invokes contents handler.
>>>
>>>    http://code.google.com/p/sepgsql/source/browse/misc/httpd-selinux/
>>>
>>> However, I don't adhere the current implementation as is.
>>> I would like to have a discussion to brush up the idea to achieve
>>> the goal and to get acceptance in the mainline.
>>>
>>> Any comments, questions and others are welcome.
>>>
>> I've been patiently hoping you would return to this idea, but it's
>> not quite tackling my problem. I was hoping for something more
>> similar to mod_privileges, where each virtual host is running in
>> a separate selinux domain. That would be very usefull for ISP's
>> offering virtual hostings to customers, and give the possibility
>> of giving guest_t shell access to multiple users with unique
>> namespaces.
>>
>> It might not be necessary to run everything within the same apache
>> process, maybe launch one per virtual host would be OK. But full
>> mod_privileges-like support would be perfect.
> 
> Yes, it seems to me your problem consciousness is also worthfull
> to achieve separation in virtual-host granularity, although its
> goal is different from what I want to do.
> 
> The purpose of my efforts is to work every web-applications with
> individual security context based on the client's identification.
> We can also say it as a mapping between a web-user and a security
> context.
> 
>> Has anybody tackled something like that with selinux ?
> 
> Sorry, my effort (currently) don't help to solve your problem.
> 
> Thanks,
You could do something very similar to what we are doing with svirt.
Take advantage of the MCS fields, for separation.  With  the
virtual-host separation, you really want each user/application to have
the exact same privledge but be totally isolated from all of the other
virtual hosts.  The way we are doing this with svirt is by using MCS
labels on both the process and the virtual image, So that when the
virtual image starts up it runs with the same access but only to one
particular mcs label.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
