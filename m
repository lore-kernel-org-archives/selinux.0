Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7KHdTsl019136
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 13:39:30 -0400
In-Reply-To: <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] Differentiate between Unix Stream Socket and Sequential
 Packet Socket
From: Guido Trentalancia <guido@trentalancia.net>
Date: Sat, 20 Aug 2016 19:39:28 +0200
To: Paul Moore <paul@paul-moore.com>
CC: selinux@tycho.nsa.gov
Message-ID: <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello Paul,

thanks for getting back on this.

The patch follows a recent discussion with Christopher PeBenito on the Reference Policy mailing list.

Christopher suggested to modify the actual code.

I suppose it provides a better insight during code analysis on the type of socket connections being made and a more fine-grained control of permissions being granted or denied to the policy designer. 

For some reason however, I have seen code using the SOCK_SEQPACKET type and executed immediately after policy load (possibly from initramfs, before switchroot) showing up in the log files as using an unspecified socket type. I have explained already to Christopher that this patch won't change such behavior...

Guido Trentalancia 

On the 20th August 2016 19:17:58 CEST, Paul Moore <paul@paul-moore.com> wrote:
>On Sat, Aug 20, 2016 at 12:18 PM, Guido Trentalancia
><guido@trentalancia.net> wrote:
>> Modify the SELinux kernel code so that it is able to differentiate
>between
>> a unix_stream_socket and a sequential_packet_socket.
>>
>> A companion patch has been created for the Reference Policy and it
>will be
>> posted to its mailing list.
>>
>> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
>> ---
>>  security/selinux/hooks.c            |    3 ++-
>>  security/selinux/include/classmap.h |    2 ++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>
>I'm going to need to hear a better explanation of why we need to make
>this change.  What problem does this solve that you can't solve today?
>
>> --- linux-4.7.1-orig/security/selinux/include/classmap.h       
>2016-08-18 17:39:50.639133429 +0200
>> +++ linux-4.7.1/security/selinux/include/classmap.h     2016-08-18
>17:52:25.921420278 +0200
>> @@ -86,6 +86,8 @@ struct security_class_mapping secclass_m
>>           { "ingress", "egress", NULL } },
>>         { "netlink_socket",
>>           { COMMON_SOCK_PERMS, NULL } },
>> +       { "sequential_packet_socket",
>> +         { COMMON_SOCK_PERMS, "connectto", NULL } },
>>         { "packet_socket",
>>           { COMMON_SOCK_PERMS, NULL } },
>>         { "key_socket",
>> --- linux-4.7.1-orig/security/selinux/hooks.c   2016-08-18
>21:47:32.204199470 +0200
>> +++ linux-4.7.1/security/selinux/hooks.c        2016-08-18
>22:52:53.099296513 +0200
>> @@ -1246,8 +1246,9 @@ static inline u16 socket_type_to_securit
>>         switch (family) {
>>         case PF_UNIX:
>>                 switch (type) {
>> -               case SOCK_STREAM:
>>                 case SOCK_SEQPACKET:
>> +                       return SECCLASS_SEQUENTIAL_PACKET_SOCKET;
>> +               case SOCK_STREAM:
>>                         return SECCLASS_UNIX_STREAM_SOCKET;
>>                 case SOCK_DGRAM:
>>                         return SECCLASS_UNIX_DGRAM_SOCKET;
