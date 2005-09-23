Message-ID: <43344661.4070209@redhat.com>
Date: Fri, 23 Sep 2005 14:16:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Russell Coker <rcoker@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Why do we have dhcp_state_t, dhcpc_state_t and dhcpd_state_t?
References: <43343670.9060708@redhat.com> <1127496706.3275.32.camel@aeon>
In-Reply-To: <1127496706.3275.32.camel@aeon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Fri, 2005-09-23 at 13:08 -0400, Daniel J Walsh wrote:
>  
>
>>Is it really valuable to isolate this data? 
>>
>>I have a bug where a dhclient program can not read its lease file 
>>because it is labeled dhcp_state_t (The same as the directory).
>>Anyone have any recollection of why it is setup this way, and any real 
>>reason I should not just make
>>dhcpc_state_t and dhcpd_state_t alias dhcp_state_t?
>>    
>>
>
>If you don't have such isolation then on a machine which runs both DHCP
>client and server (typical of a firewall) then the DHCP client (which
>will be attacked from the Internet - mine is regularly) will have the
>ability to indirectly control the DHCP server.
>
>DHCP servers which have the most hostile DHCP clients will probably not
>be running DHCP client programs on other interfaces.
>
>If we are going to merge those two types then perhaps the right thing to
>do would be to merge dhcpd_t and dhcpc_t and have a boolean to determine
>whether DHCP client functionality should be permitted.
>  
>
Ok I have talked to the dhcp maintainer hear and he is looking into 
moving the lease files into their own
directory, to eliminate this problem.  So if we end up with

/var/lib/dhclient/
and
/var/lib/dhcpd/

Then we can label the directories correctly and eliminate the overlap.



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
