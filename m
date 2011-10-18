MIME-Version: 1.0
In-Reply-To: <00243337-937e-4e6b-880b-ba2f351112e7@email.android.com>
References: <4E7B9233.6080609@redhat.com>
	<1316723465.2354.6.camel@moss-pluto>
	<4E7B9B43.9000400@redhat.com>
	<1316723821.2354.9.camel@moss-pluto>
	<1316724121.2354.12.camel@moss-pluto>
	<4E7C9F3D.9030704@redhat.com>
	<1316790421.10259.70.camel@moss-pluto>
	<CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com>
	<1317139611.22218.9.camel@moss-pluto>
	<4E82123C.4070406@redhat.com>
	<4E985BFB.1000806@redhat.com>
	<4E9D7267.9060004@tresys.com>
	<00243337-937e-4e6b-880b-ba2f351112e7@email.android.com>
Date: Tue, 18 Oct 2011 18:07:24 -0400
Message-ID: <CAEXv5_h=OxxNUnzFOihpjKSCrQ492N9s_UmwdujFneQ1zk2g4g@mail.gmail.com>
Subject: Re: I would like to change the behavior of MCS label creations in directory.
From: David Windsor <dwindsor@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My client truncated my earlier message.

Is per-object granularity sufficient, or would a tuple of
(user/role/type, object) be a better key for indexing these rules?
This makes sense for the role and type fields of a context, but I'm
not so sure about the user field.

Examples:

default_user NetworkManager_t dir_file_class process;
default_role NetworkManager_t dir_file_class process;
default_type NetworkManager_t dir_file_class process;

I'm just unsure that per-object granularity is sufficient.  Thoughts?

Thanks,
David

On Tue, Oct 18, 2011 at 8:58 AM, David Windsor <dwindsor@gmail.com> wrote:
> "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
>>
>> On 10/14/11 11:57, Daniel J Walsh wrote:
>> > Eric and I have come up with the following syntax for this behaviour.
>> >
>> > default_trans level dir_file_class_set parent;
>>
>> I think we want this to be "range" instead of "level", since the field is
>> actually a range.
>>
>> > default_trans user dir_file_class_set process;
>> > default_trans role file parent;
>>
>> Isn't there a better set of tokens than this?  Why not make it
>> default_user, default_role, default_type, and default_range?  Creating an
>> object doesn't really imply a transition, so "trans" seems misleading.
>>
>> --
>> Chris PeBenito
>> Tresys Technology, LLC
>> www.tresys.com | oss.tresys.com
>
> Also, do we want to add the ability to specify a source type for default
> transitions so that transitions can be controlled with more granularity than
> on a per-object basis? For instance:
>
> default_user http



-- 
PGP: 6141 5FFD 11AE 9844 153E  F268 7C98 7268 6B19 6CC9


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
