Subject: Re: SEAndroid make_ext4fs fails with new changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Subramani Venkatesh <selinuxv31@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAD8iFzxwJSwJ+LGzByLN9sskyy5UiW-6zGWNOmJ0Fu6X1_EsbQ@mail.gmail.com>
References: 
	 <CAD8iFzxwJSwJ+LGzByLN9sskyy5UiW-6zGWNOmJ0Fu6X1_EsbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Mar 2012 11:35:12 -0500
Message-ID: <1331138112.16697.54.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-07 at 11:24 -0500, Subramani Venkatesh wrote:
> Hi,
> I synced SE Android code this morning, facing some issues with
> make_ext4fs, here is the log
> 
> make_ext4fs -s -S out/target/product/maguro/root/file_contexts -l
> 14539537408 -a data out/target/product/maguro/userdata.img
> out/target/product/maguro/data
> Creating filesystem with parameters:
>     Size: 14539534336
>     Block size: 4096
>     Blocks per group: 32768
>     Inodes per group: 8144
>     Inode size: 256
>     Journal blocks: 32768
>     Label:
>     Blocks: 3549691
>     Block groups: 109
>     Reserved block group size: 871
> error: make_ext4fs_internal: cannot lookup security context for /data
> 
> Is anyone else facing the same issue?

What does your out/target/product/maguro/root/file_contexts contain?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
