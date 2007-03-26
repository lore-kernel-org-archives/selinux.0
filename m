Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QJBe7A021984
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 15:11:40 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2QJBdRM016392
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 19:11:39 GMT
Message-ID: <46081AE0.5070703@redhat.com>
Date: Mon, 26 Mar 2007 15:11:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Elimination of disable_trans boolean ramifications
References: <46041166.8010102@redhat.com> <1174927405.12204.51.camel@localhost.localdomain>
In-Reply-To: <1174927405.12204.51.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Fri, 2007-03-23 at 13:41 -0400, Daniel J Walsh wrote:
>   
>> I have removed the disable_trans booleans from Rawhide, and FC7 Test3.  
>> I wanted to remove these booleans because they cause as many problems as 
>> they solve.    If you turn off certain domains, it can change the 
>> labeling on the system and cause other confined domains to blow up.
>>
>> If you syslog_disable_trans, the devlog_t context is wrong and any 
>> confined app that tries to syslog will no longer work.
>>
>> The best thing to do when confronted with an AVC would be to figure out 
>> if this is expected behavior, if yes then report it as a bug to upstream 
>> or to the distribution and create a loadable policy module that handles 
>> the problem.
>>
>> If there are so many problems or a user just does not want to deal with 
>> it I figured we could just load a policy that sets the domain as an 
>> unconfined_domain.
>>
>> If you wanted to run samba as an unconfined domain  you would build a 
>> policy module
>>
>> policy_module(mysamba, 1.0)
>>
>> require {
>>         type smbd_t;
>> }
>>
>> unconfined_domain(smbd_t)
>>
>>
>>     
>
> So - I like this idea from a technical point-of-view. The only concern
> is that users are used to looking for a booleans for this type of thing.
> There is some hope that they would discover the changed booleans poking
> around a gui tool or using g/setsebool. I don't think most users would
> never think to create a module to make a domain unconfined. Plus, the
> directions on how to do this go from a single command to several.
>
> I've heard concern that the number of booleans is growing too large. I
> would suggest that if that is your motivation for avoiding booleans that
> we find a way to organize them instead.
>
> Karl
>   
I think turning a domain unconfined_domain should be the last resort.  
(Or I guess better then chcon -t bin_t EXEC)

I think adding a boolean makes it too easy for them.

The response to an AVC would be best if it involved the following:

1. Ignore AVC if the app works. Reporting a bugzilla against the package 
that created it.  Leaked file descriptor or daemons trying to talk to 
terminals are classic examples of this.
2. If setroubleshoot suggests a boolean or file_context to set then set 
it and see if the app works.
3. audit2allow -M myEXEC -i /var/log/audit/audit.log  to "fix" the 
policy for the app  (BUGZILLA)
4. New tool to create unconfined_domain policy package for running 
daemon unconfined (BUGZILLA)
5. chcon -t bin_t EXEC (BUGZILLA)
6. setenforce 0 (BUGZILLA)
7. selinux=0 (BUGZILLA)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
