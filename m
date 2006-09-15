Message-ID: <450AC895.3060905@redhat.com>
Date: Fri, 15 Sep 2006 11:36:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ipsec, netlabels, secmark- How about a little usability?
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com> <1158245034.25629.65.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1158245034.25629.65.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-09-14 at 09:50 -0400, Joshua Brindle wrote:
>   
>>> 1.  By default httpd has to be able to talk to itself in order to do 
>>> gracefull shutdown,
>>> service httpd graceful.
>>>
>>> So I end up adding a rule allowing httpd to name_connect to the 
>>> httpd_port_t.    But I really only want to allow this for localhost.  
>>> IE I don't want to allow my httpd to name_connect to other machines 
>>> httpd ports?  I can't do this now.
>>>
>>>       
>> you can with secmark can't you?
>> iptables -I -p tcp -d localhost -s localhost -i lo --dport 80 -j SECMARK 
>> --selctx system_u:object_r:httpd_client_packet_t
>>     
>
> IIUC, the mechanism is there, but the necessary integration is not.  How
> do we intend to manage local secmark rules, via semanage as with
> port/node/netif contexts or via iptables?  How does one express this
> kind of goal in refpolicy itself, going beyond just the support for auto
> generation of dport-based rules?  Where do we stand on iptables
> integration?
>
>   
I still think this is not fully thought out. We have a lot of booleans 
that this stuff will blow out of the water.  setsebool -A 
allow_ypbind=1  for example,  httpd_can_connect_any ...  Are these 
things going to have to replace iptables rules when they get set?  I 
find the hole thing unmanagable and I think we are going to see 
performance problems when we start adding hundreds (thousands) of rules 
to iptables.

I believe we need an integrated solution that can setup full networking 
support, in which I state that
Domain X on Host Y can talk to Domain A on Host B.  This needs to be 
able to setup the proper network requirements to make this happen.  If 
this is a combination of secmark rules, and netlabel/ipsec that is 
fine.  But I don't expect many admins in to be able to set this up on 
their own.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
