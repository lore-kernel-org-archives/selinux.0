Message-ID: <5265905B.2020703@tycho.nsa.gov>
Date: Mon, 21 Oct 2013 16:36:43 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe MacDonald <joe@deserted.net>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] libselinux: avoid shadowing 'stat' in load_mmap
References: <1382383000-16439-1-git-send-email-joe@deserted.net> <1382383000-16439-2-git-send-email-joe@deserted.net> <1382383000-16439-3-git-send-email-joe@deserted.net>
In-Reply-To: <1382383000-16439-3-git-send-email-joe@deserted.net>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/21/2013 03:16 PM, Joe MacDonald wrote:
>    label_file.c: In function ‘load_mmap’:
>    label_file.c:238:81: error: declaration of ‘stat’ shadows a global declaration [-Werror=shadow]
>    cc1: all warnings being treated as errors

I don't particularly mind the change, but I neither see this warning nor
see the underlying issue in the source code - where is the global stat
declaration?  Is it in some system header file you have on your system?

> 
> Signed-off-by: Joe MacDonald <joe@deserted.net>
> ---
>  libselinux/src/label_file.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 51520cf..af7c227 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -235,7 +235,7 @@ static int process_line(struct selabel_handle *rec,
>  	return 0;
>  }
>  
> -static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *stat)
> +static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *sb)
>  {
>  	struct saved_data *data = (struct saved_data *)rec->data;
>  	char mmap_path[PATH_MAX + 1];
> @@ -266,13 +266,13 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>  	}
>  
>  	/* if mmap is old, ignore it */
> -	if (mmap_stat.st_mtime < stat->st_mtime) {
> +	if (mmap_stat.st_mtime < sb->st_mtime) {
>  		close(mmapfd);
>  		return -1;
>  	}
>  
> -	if (mmap_stat.st_mtime == stat->st_mtime &&
> -	    mmap_stat.st_mtim.tv_nsec < stat->st_mtim.tv_nsec) {
> +	if (mmap_stat.st_mtime == sb->st_mtime &&
> +	    mmap_stat.st_mtim.tv_nsec < sb->st_mtim.tv_nsec) {
>  		close(mmapfd);
>  		return -1;
>  	}
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
