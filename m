Message-ID: <4B8833C6.9070503@tycho.nsa.gov>
Date: Fri, 26 Feb 2010 15:49:10 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov
Subject: Re: avc_open() and netlink_loop()
References: <4B691583.5060608@ak.jp.nec.com> <4B881D79.4000500@tycho.nsa.gov>
In-Reply-To: <4B881D79.4000500@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/26/2010 02:14 PM, Eamon Walsh wrote:
> On 02/03/2010 01:19 AM, KaiGai Kohei wrote:
>> When we initialize userspace avc using avc_open(3), it internally calls
>> avc_init(3) without any callback functions. The avc_init() is introduced
>> as a deprecated interface from application code, so it is recommended to
>> use avc_open() instead for new applications.
>>
>> The avc_init() internally calls avc_netlink_open(). If no thread callback
>> is not given, the 'blocking' argument shall be 0, then avc_netlink_open()
>> set O_NONBLOCK flag on the socket file descriptor.
>>
>> Next, application will create a thread to receive messages via netlink
>> socket to invalidate userspace avc, using avc_netlink_loop().
>> However, if userspace avc of libselinux is already initialized,
>> the avc_netlink_loop() immediately returns with EWOULDBLOCK, because the
>> netlink socket is not blocked and avc_netlink_receive() does not expect
>> recvfrom() returns error.
>>
>> It seems to me O_NONBLOCK is a wrong strategy in this case, and select(2)
>> should be checked in avc_netlink_check_nb() instead.
>>
>> Eamon, what is your opinion?
>>   
> 
> 
> Hi, my apologies for the delayed response. Yes it appears as though this
> is a bug. I think the solution is to configure the file descriptor in
> blocking mode at the start of avc_netlink_loop(). When
> avc_netlink_loop() is called, we always want blocking behavior. See the
> attached patch.
> 
> 

Also, before you launch a thread to run avc_netlink_loop(), you need to call avc_netlink_acquire_fd().  Otherwise, the avc will internally make calls to avc_netlink_check_nb() which will not work properly.


-- 
Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
