MIME-Version: 1.0
In-Reply-To: <1331143930.16697.59.camel@moss-pluto>
References: <CAD8iFzxwJSwJ+LGzByLN9sskyy5UiW-6zGWNOmJ0Fu6X1_EsbQ@mail.gmail.com>
	<1331138112.16697.54.camel@moss-pluto>
	<CAD8iFzy_fpPEwoJ0q8563NjhuisQ1uz5GebtYojhsysZdoHfpQ@mail.gmail.com>
	<1331143930.16697.59.camel@moss-pluto>
Date: Wed, 7 Mar 2012 13:23:44 -0500
Message-ID: <CAD8iFzx4gKLSep_kVx5tN5A0PoA6oDEXDf5eeaiX4HL5MunjPw@mail.gmail.com>
Subject: Re: SEAndroid make_ext4fs fails with new changes
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had something like "+/dev/ttyFIQ[0-9]*
u:object_r:tty_device:s0", until I erase obj files, It did not work
for me.
I myself not able to reproduce it now.

Regards,
Subbu
> On Wed, 2012-03-07 at 11:55 -0500, Subramani Venkatesh wrote:
>> Hi Stephen,
>> I created 2 files sepolicy.fc and sepolicy.te in
>> device/samsung/<TARGET_BOARD>/, there was one error in sepolicy.fc
>> file, I fixed it, but then when I rebuild the changes are not taking
>> affect, it shows error file. Probably I have to delete
>> obj/ETC/sepolicy_intermediates and rebuild it.
>
> Hmm...I couldn't seem to reproduce.  What exactly did you have in your
> sepolicy.fc file originally, and how did you "fix" it?  Did the fixed
> version have a newer timestamp than the broken one?
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
