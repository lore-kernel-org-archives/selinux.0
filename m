Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4SHOT6e009294
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 13:24:29 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4SHOSOB005164
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 17:24:28 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1798168fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 10:24:25 -0700 (PDT)
Message-ID: <cadfc0e40805281018g954170et2bb00a87039e780f@mail.gmail.com>
Date: Wed, 28 May 2008 12:18:20 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: copy/paste policy patch
Cc: "Eamon Walsh" <ewalsh@tycho.nsa.gov>, "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1210084037.8276.28.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
	 <1209386863.30483.44.camel@gorn.columbia.tresys.com>
	 <4816523B.4030905@tycho.nsa.gov>
	 <cadfc0e40804281546n188882c2w2c84241878f2d7ef@mail.gmail.com>
	 <481900C9.40406@tycho.nsa.gov> <1210084037.8276.28.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 6, 2008 at 9:27 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Wed, 2008-04-30 at 19:29 -0400, Eamon Walsh wrote:
>> Xavier Toth wrote:
>> > Seems to me that paste mlsconstrain should be (l1 eq l2) and should be
>> > a mlsconstrain for paste_after_confirm which is (l1 domby l2).
>>
>> Revised patch attached.
>
> Merged.
>
>> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
>> ---
>>
>> Index: policy/flask/security_classes
>> ===================================================================
>> --- policy/flask/security_classes     (revision 2669)
>> +++ policy/flask/security_classes     (working copy)
>> @@ -114,5 +114,6 @@
>>  class x_resource             # userspace
>>  class x_event                        # userspace
>>  class x_synthetic_event              # userspace
>> +class x_application_data     # userspace
>>
>>  # FLASK
>> Index: policy/flask/access_vectors
>> ===================================================================
>> --- policy/flask/access_vectors       (revision 2669)
>> +++ policy/flask/access_vectors       (working copy)
>> @@ -775,3 +775,10 @@
>>  {
>>       recv
>>  }
>> +
>> +class x_application_data
>> +{
>> +     paste
>> +     paste_after_confirm
>> +     copy
>> +}
>> Index: policy/mls
>> ===================================================================
>> --- policy/mls        (revision 2669)
>> +++ policy/mls        (working copy)
>> @@ -568,7 +568,19 @@
>>        ( t1 == mlsxwinwrite ));
>>
>>
>> +#
>> +# MLS policy for the x_application_data class
>> +#
>>
>> +# the x_application_data "paste" ops (explicit single level)
>> +mlsconstrain x_application_data { paste }
>> +     ( l1 eq l2 );
>> +
>> +# the x_application_data "paste_after_confirm" ops (downgrade permitted)
>> +mlsconstrain x_application_data { paste_after_confirm }
>> +     ( l1 domby l2 );
>> +
>> +
>>  #
>>  # MLS policy for the pax class
>>  #
>>
>>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

Here's what I've actually ended up using to allow pasting equal or up
without requiring confirmation and to require confirmation when
attempting to paste down:

Index: policy/mls
===================================================================
--- policy/mls	(revision 2704)
+++ policy/mls	(working copy)
@@ -574,11 +574,11 @@

 # the x_application_data "paste" ops (explicit single level)
 mlsconstrain x_application_data { paste }
-	( l1 eq l2 );
+	(( l1 eq l2 ) or ( l1 domby l2 ));

 # the x_application_data "paste_after_confirm" ops (downgrade permitted)
 mlsconstrain x_application_data { paste_after_confirm }
-	( l1 domby l2 );
+	( l1 dom l2 );


 #

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
