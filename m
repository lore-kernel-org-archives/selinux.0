Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k01HVPXf000800
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 12:31:25 -0500 (EST)
Received: from www346.sakura.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k01HUNbK015234
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 17:30:24 GMT
Message-ID: <43B811E9.9000907@kaigai.gr.jp>
Date: Mon, 02 Jan 2006 02:31:21 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-security-module@wirex.com, "SELinux(NSA)" <selinux@tycho.nsa.gov>
Subject: Re: SELinux metadata protection
References: <43B6C9E3.8020406@kaigai.gr.jp> <20060101153856.GA15767@sergelap.austin.ibm.com>
In-Reply-To: <20060101153856.GA15767@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, thanks for your comments.

Serge E. Hallyn wrote:
> Quoting KaiGai Kohei (kaigai@kaigai.gr.jp):
> 
>>It seems a bit curious behavior for me. Why can an unauthorized process
>>be allowed to know whether the file exists or not ?
>>I think it's worthwhile to conceal the existence of files from unauthorized
>>processes.
> 
> 
> This behavior is also necessary for meeting the new medium robustness
> protection profiles.

Hmm... I'm not so familiar with ISO-15408.
Do you know previous discussions about such behavior on filename resolving or readdir ?

>>--- linux-2.6.14.5-selinux/fs/readdir.c	2005-12-26 19:26:33.000000000 -0500
>>+++ linux-2.6.14.5-selinux.mp/fs/readdir.c	2005-12-29 20:26:55.000000000 -0500
>>@@ -33,7 +33,11 @@ int vfs_readdir(struct file *file, filld
>> 	down(&inode->i_sem);
>> 	res = -ENOENT;
>> 	if (!IS_DEADDIR(inode)) {
>>-		res = file->f_op->readdir(file, buf, filler);
>>+		/* NOTE:
>>+		   When LSM was not enable, security_file_readdir()
>>+		   is same as 'file->f_op->readdir()'. 
>>+		*/
>>+		res = security_file_readdir(file, buf, filler);
>> 		file_accessed(file);
> 
> 
> I don't like this - the dir->f_op->readdir should not be done inside
> a function which claims to be a security check.  Plus the added code
> doesn't have a return value of it's own.  So why not stay closer to usual
> linux code and do something like
> 
> 	security_prep_readdir();
> 	res = file->f_op->readdir(file, buf, filler);
> 
> inside vfs_readdir(), where security_prep_readdir() is defined away
> in the non-LSM case, and is 
> 
> 
>>+static inline void security_file_readdir (struct file *dir, void *buffer, filldir_t filler)
>>+{
>>+	security_filldir_t private;
>>+
>>+	private.dir = dir;
>>+	private.buffer = buffer;
>>+	private.filler = filler;
> 
> 
> in the LSM case?

Indeed, file->f_op->readdir() need not necessary to be called inside LSM function.
But overwriting 'filler' is necessary to check permission for each directory entry.
I agree your suggestion if security_prep_readdir() is defined as macro, and
this can overwrite 'filler' and 'buf'.

Pay attention to what 'filler' was overwritten in this patch.
When LSM is enable, FS's readdir method (dir->f_op->readdir) always calls 'security_file_filldir'
for each directory entry instead of original 'filler' given by arguments.
When 'security_file_filldir' is called for authorized directory entry, it calls original 'filler'
for writing the entry into userspace. But 'security_file_filldir' is called for unauthorized
directory entry, it skips to call original 'filler'.
In the result, only authorized directory entries are returned to userspace.
The above code is necessary to implement such behavior.

* in normal case
vfs_readdir()
  -> FS's readdir method
     - entry-1  -> filldir("entry-1")
     - entry-2  -> filldir("entry-2")
          :
     - entry-N  -> filldir("entry-N")
RESULT: all entries are returned to userspace.

* in metadata protection case
vfs_readdir()
  -> FS's readdir method
     - entry-1  -> security_file_filldir("entry-1") -> filldir("entry-1), if permitted
     - entry-2  -> security_file_filldir("entry-2") -> filldir("entry-2), if permitted
          :
     - entry-N  -> security_file_filldir("entry-N") -> filldir("entry-N), if permitted
RESULT: only authorized entries are returned to userspace.

Thanks,

# BTW, why doesn't deliver the first mail of this thread I posted in SELinux-list?
--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
