MIME-Version: 1.0
In-Reply-To: <1331138112.16697.54.camel@moss-pluto>
References: <CAD8iFzxwJSwJ+LGzByLN9sskyy5UiW-6zGWNOmJ0Fu6X1_EsbQ@mail.gmail.com>
	<1331138112.16697.54.camel@moss-pluto>
Date: Wed, 7 Mar 2012 11:55:00 -0500
Message-ID: <CAD8iFzy_fpPEwoJ0q8563NjhuisQ1uz5GebtYojhsysZdoHfpQ@mail.gmail.com>
Subject: Re: SEAndroid make_ext4fs fails with new changes
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,
I created 2 files sepolicy.fc and sepolicy.te in
device/samsung/<TARGET_BOARD>/, there was one error in sepolicy.fc
file, I fixed it, but then when I rebuild the changes are not taking
affect, it shows error file. Probably I have to delete
obj/ETC/sepolicy_intermediates and rebuild it.


Regards,
Subbu

On Wed, Mar 7, 2012 at 11:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2012-03-07 at 11:24 -0500, Subramani Venkatesh wrote:
>> Hi,
>> I synced SE Android code this morning, facing some issues with
>> make_ext4fs, here is the log
>>
>> make_ext4fs -s -S out/target/product/maguro/root/file_contexts -l
>> 14539537408 -a data out/target/product/maguro/userdata.img
>> out/target/product/maguro/data
>> Creating filesystem with parameters:
>>     Size: 14539534336
>>     Block size: 4096
>>     Blocks per group: 32768
>>     Inodes per group: 8144
>>     Inode size: 256
>>     Journal blocks: 32768
>>     Label:
>>     Blocks: 3549691
>>     Block groups: 109
>>     Reserved block group size: 871
>> error: make_ext4fs_internal: cannot lookup security context for /data
>>
>> Is anyone else facing the same issue?
>
> What does your out/target/product/maguro/root/file_contexts contain?
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
