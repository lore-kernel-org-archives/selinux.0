Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2FtYXZ006887
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 10:55:34 -0500 (EST)
Message-ID: <4187ADEF.5030803@redhat.com>
Date: Tue, 02 Nov 2004 10:55:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <200411030027.28875.russell@coker.com.au> <41879A1B.40103@redhat.com> <200411030248.49998.russell@coker.com.au>
In-Reply-To: <200411030248.49998.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Wed, 3 Nov 2004 01:30, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>>dictd_t is not permitted to bind to any low ports.  How does it need
>>>net_bind_service capability?
>>>      
>>>
>>Maybe ypbind also.
>>    
>>
>
>OK.  If you change the ypbind macro then things should be fine in that regard.
>
>  
>
>>>+allow hald_t { device_t }:{ chr_file } { create_file_perms };
>>>
>>>Three sets of redundant braces.  Why does it need to create character
>>>device nodes anyway?  We have udev to do that!
>>>      
>>>
>>Hal creates a device when using cardmgr. pcmcia currently does not work
>>with udev.
>>
>>    
>>
>>>+file_type_auto_trans(kudzu_t, tmp_t, kudzu_tmp_t, chr_file)
>>>
>>>Why is kudzu creating device nodes under /tmp?  This sounds like a bug in
>>>kudzu to me.
>>>      
>>>
>>I think cardmgr again.
>>    
>>
>
>Are they executing cardmgr or cardctl?  If so then there should be a 
>domain_auto_trans() rule to get it running in cardmgr_t, doing otherwise may 
>interfere with other cardmgr operations later.
>
>I'm surprised that I haven't seen this though as I've got a couple of laptops 
>tracking rawhide.  Did you boot with a PCMCIA/Cardbus card installed?  Is 
>there anything unusual about your setup?  What model of laptop?
>  
>
ibm thinkpad.  I have booted with it in and without it, also have 
started and stopped hal which causes the problem.

>  
>
>>>Why isn't allow $1 self:{ tcp_socket udp_socket } connect; in
>>>can_network()?
>>>      
>>>
>>Because we don't want all network daemons to be able to connect out.
>>    
>>
>
>Then we should have two macros, one that allows outbound connections and one 
>that doesn't.  Increasing the line count in most domains that have network 
>access does no good.
>
>  
>
I wanted to treat connect the same way we treat name_bind.  Basically 
you need to explicitly state whether a network daemon is inbout, 
outbound or both.  If we want to add all the macros fine, but having 
can_network default to allowing connect is too loose, think of spammers.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
