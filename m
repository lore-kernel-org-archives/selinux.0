From: <ken.masumitsu@accenture.com>
To: <sds@tycho.nsa.gov>
CC: <SELinux@tycho.nsa.gov>
Subject: Re: Denials of changing wallpaper on Galaxy Nexus
Date: Wed, 27 Jun 2012 02:33:06 +0000
Message-ID: <ECD1E95F29248A4AA3FFC99C6947D66C0A49CB68@048-CH1MPN1-082.048d.mgd.msft.net>
References: <4FE43B1B.1030602@accenture.com>
  <1340368300.14703.35.camel@moss-pluto.epoch.ncsc.mil>
  <1340370788.14703.38.camel@moss-pluto.epoch.ncsc.mil>
  <ECD1E95F29248A4AA3FFC99C6947D66C0A4917F5@048-CH1MPN1-082.048d.mgd.msft.net>
 <1340626293.22057.28.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1340626293.22057.28.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

Thanks for your careful explanations.
I could understand it.


On 2012年06月25日 21:11, Stephen Smalley wrote:
> On Mon, 2012-06-25 at 02:50 +0000, ken.masumitsu@accenture.com wrote:
>> Hi,
>>
>> Thanks for your comments.
>> I could change wallpaper by modifying file.te you suggested.
>>
>> However, I have one question.
>> How do you find/investigate the deny comes from MSL?
>>
>> Because, though I interpreted the log as
>>       The object (wallpaper file) had no category and sensitivity of the
>> object and the subject were same.
>>       The access was allowed by MLS.
>> the guess was incorrect.
>>
>> ---------------------------------------------------------------------------------------
>>
>> <5>[ 508.922760] type=1400 audit(1340350990.015:190): avc: denied {
>> write } for pid=565 comm=42696E646572205468726561642023
>> path="/data/data/com.android.settings/files/wallpaper" dev=mmcblk0p12
>> ino=578429 scontext=u:r:trusted_app:s0:c17
>> tcontext=u:object_r:wallpaper_file:s0 tclass=file
>>    ---------------------------------------------------------------------------------------
> The subject dominated the object due to its category set.  Such a write
> would have been a write-down and thus violated the BLP *-property.  The
> relevant constraint in the sepolicy/mls file was:
> mlsconstrain { file lnk_file sock_file chr_file blk_file } { write
> setattr append unlink link rename }
>               (t2 == app_data_file or l1 domby l2 or t1 ==
> mlstrustedsubject or t2 == mlstrustedobject);
>
> Some helpful documentation written by others can be found at:
> http://selinuxproject.org/page/NB_MLS
>
> The book SELinux By Example may also be helpful in understanding the MLS
> model and constraint syntax for SELinux.
>


________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
