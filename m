Message-ID: <cadfc0e40812300719h62e668b8ga138e5bbd5bb04fe@mail.gmail.com>
Date: Tue, 30 Dec 2008 09:19:10 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>, refpolicy@oss.tresys.com,
        "Daniel J Walsh" <dwalsh@redhat.com>
Subject: [PATCH] Policy:setrans.te - Re: [RFC] Add color translation support to mcstransd
Cc: "Joe Nall" <joe@nall.com>, "SELinux List" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 24, 2008 at 10:23 AM, Xavier Toth <txtoth@gmail.com> wrote:
> On Thu, Dec 11, 2008 at 3:35 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>> Xavier Toth wrote:
>>>
>>> Sorry to be pedantic but is there a reference implementation or will
>>> the mcstrans developer (Joe) have to develop it?
>>>
>>> Ted
>>>
>>
>> Also here is a preliminary libselinux patch.
>>
>>
>> --
>> Eamon Walsh <ewalsh@tycho.nsa.gov>
>> National Security Agency
>>
>>
>
> This patch could be upstreamed now because even if the installed
> mcstrand doesn't support color a call to selinux_raw_context_to_color
> will simply retrun an error, right?
>
> Ted
>

In anticipation of the addition of SELinux color mapping support to
libselinux and mcstransd I wrote this policy patch :

------------------------------------------------------------------------------------------------------------------------------

Allow mcstransd to uses the CONTEXT__CONTAINS permission check to check
dominance when determining the colors to return for calls to
selinux_raw_context_to_color.

--- serefpolicy-3.5.13/policy/modules/system/setrans.te.orig	2008-12-30
08:43:31.000000000 -0600
+++ serefpolicy-3.5.13/policy/modules/system/setrans.te	2008-12-30
08:46:26.000000000 -0600
@@ -35,6 +35,11 @@
 allow setrans_t self:unix_stream_socket create_stream_socket_perms;
 allow setrans_t self:unix_dgram_socket create_socket_perms;
 allow setrans_t self:netlink_selinux_socket create_socket_perms;
+gen_require(`
+	class context contains;
+')
+
+allow setrans_t self:context contains;

 can_exec(setrans_t, setrans_exec_t)
 corecmd_search_bin(setrans_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
